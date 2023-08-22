-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/Lazyvim/Lazyvim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- 定义一个函数来设置文件类型的缩进选项
local function set_indent_options()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  -- 根据不同的文件类型设置缩进选项
  if filetype == "python" then
    vim.api.nvim_buf_set_option(0, "tabstop", 4)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
  elseif filetype == "lua" then
    vim.api.nvim_buf_set_option(0, "tabstop", 2)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 2)
  else
    -- 默认的缩进选项
    vim.api.nvim_buf_set_option(0, "tabstop", 4)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
  end
end

-- 在 BufEnter 事件中调用函数设置缩进选项
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("indent"),
  pattern = {
    "*",
  },
  callback = function(event)
    set_indent_options()
  end,
})
