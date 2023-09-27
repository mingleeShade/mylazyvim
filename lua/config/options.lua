-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/Lazyvim/Lazyvim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.foldmethod = "manual"
opt.undofile = false
opt.swapfile = false
opt.wrap = true
-- 通用的通过 lua 设置 vim 属性的命令
-- vim.cmd 'se noswf'

-- vim-oscyank
vim.g.oscyank_max_length = 1000000
vim.g.oscyank_term = 'tmux'
vim.g.oscyank_silent = true

-- any-jump
-- let g:any_jump_ignored_files = ['*.tmp', '*.temp', '*.i', '*.log', 'doc/*']
-- let g:any_jump_window_width_ratio  = 0.9
-- let g:any_jump_window_height_ratio = 0.9
-- let g:any_jump_window_top_offset   = 1

vim.g.any_jump_ignored_files = {'*.tmp', '*.temp', '*.i', '*.log', 'doc/*'}
vim.g.any_jump_window_width_ratio  = 0.9
vim.g.any_jump_window_height_ratio = 0.9
vim.g.any_jump_window_top_offset   = 1

-- vim-translator
-- vim.g.translator_default_engines = {'bing', 'haici'}
-- vim.g.translator_window_type = 'preview'
