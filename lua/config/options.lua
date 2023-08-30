-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/Lazyvim/Lazyvim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.foldmethod = "manual"
opt.undofile = false
opt.swapfile = false
-- 通用的通过 lua 设置 vim 属性的命令
-- vim.cmd 'se noswf'
