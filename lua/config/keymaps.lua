-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/Lazyvim/Lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({lhs, mode = mode}).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- Cursor move when insert mode
map("i", "<C-h>", "<Left>", {desc = "Cursor move left"})
map("i", "<C-j>", "<Down>", {desc = "Cursor move down"})
map("i", "<C-k>", "<Up>", {desc = "Cursor move up"})
map("i", "<C-l>", "<Right>", {desc = "Cursor move right"})

-- DF for esc
-- map("i", "df", "<ESC>", {desc = "df replace ESC"})
-- map("v", "df", "<ESC>", {desc = "df replace ESC"})

-- Format keymap 改为直接替换 lsp 的format keymap
-- map("n", "<leader>cF", ":Format<CR>", {desc = "Format"})

-- vim-fugitive
map("n", "<leader>gb", "<cmd>Git blame<cr>", {desc = "Git blame"})

-- nvim-blame-line
-- map("n", "<leader>gB", "<cmd>ToggleBlameLine<CR>", {desc = "Toggle blame line"})

-- vim-translator
-- Echo translation in the cmdline
-- map("n", "<leader>tt", "<Plug>Translate", {desc = "Translate (cmdline)", silent = true})
-- map("v", "<leader>tt", "<Plug>TranslateV", {desc = "Translate (cmdline)", silent = true})
-- -- Display translation in a window
-- map("n", "<leader>tw", "<Plug>TranslateW", {desc = "Translate (window)", silent = true})
-- map("v", "<leader>tw", "<Plug>TranslateWV", {desc = "Translate (window)", silent = true})
-- -- Replace the text with translation
-- map("n", "<leader>tr", "<Plug>TranslateR", {desc = "Translate and replace", silent = true})
-- map("v", "<leader>tr", "<Plug>TranslateRV", {desc = "Translate and replace", silent = true})
-- -- Translate the text in clipboard
-- map("n", "<leader>tx", "<Plug>TranslateX", {desc = "Translate in clipboard", silent = true})
