-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/Lazyvim/Lazyvim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, {clear = true})
end

-- 定义一个函数来设置文件类型的缩进选项
local function set_indent_options()
  local opts = {}
  -- opts["scope"] = "local"
  opts["buf"] = 0
  local filetype = vim.api.nvim_get_option_value("filetype", opts)

  -- 根据不同的文件类型设置缩进选项
  if filetype == "python" then
    vim.api.nvim_set_option_value("tabstop", 4, opts)
    vim.api.nvim_set_option_value("shiftwidth", 4, opts)
  elseif filetype == "lua" then
    local Util = require("lazyvim.util")
    local root_path = Util.root.get()
    if vim.fn.filereadable(vim.fn.expand(root_path .. "/stylua.toml")) == 1 then
      vim.api.nvim_set_option_value("tabstop", 2, opts)
      vim.api.nvim_set_option_value("shiftwidth", 2, opts)
    else
      vim.api.nvim_set_option_value("tabstop", 4, opts)
      vim.api.nvim_set_option_value("shiftwidth", 4, opts)
    end
  elseif filetype == "html" then
    vim.api.nvim_set_option_value("tabstop", 2, opts)
    vim.api.nvim_set_option_value("shiftwidth", 2, opts)
  else
    -- 默认的缩进选项
    vim.api.nvim_set_option_value("tabstop", 4, opts)
    vim.api.nvim_set_option_value("shiftwidth", 4, opts)
  end
end

-- 在 BufEnter 事件中调用函数设置缩进选项
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("indent"),
  pattern = {"*"},
  callback = function(_)
    set_indent_options()
  end
})

-- formatter
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("formatter"),
  pattern = {
    "*.h",
    "*.hpp",
    "*.c",
    "*.cc",
    "*.cpp",
    "*.html",
    "*.css",
    "*.js",
    "*.py",
    "*.md",
  },
  callback = function(_)
    vim.cmd("FormatWrite")
  end
})

-- vim-oscyank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("oscyank"),
  pattern = {"*"},
  callback = function(_)
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      vim.cmd('OSCYankReg "')
    end
  end
})

-- nvim-blame-line
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("nvim-blame-line"),
--   pattern = {"*"},
--   callback = function(_)
--     vim.cmd("EnableBlameLine")
--   end
-- })
