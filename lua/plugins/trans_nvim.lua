return {
  {
    "JuanZoran/Trans.nvim",
    build = function () require'Trans'.install() end,
    keys = {
      {"<leader>tt", mode = {'n', 'x'}, '<Cmd>Translate<CR>', desc = "Translate" },
      -- {"<leader>tp", mode = {'n', 'x'}, '<Cmd>TransPlay<CR>', desc = "Auto play" },
      {"<leader>ti", '<Cmd>TranslateInput<CR>', desc = "Translate from input" },
    },
    dependencies = { 'kkharji/sqlite.lua', },
    opts = {
      frontend = {
        hover = {
          keymaps = {
            pageup = '<C-u>',
            pagedown = '<C-d>',
            pin = '<leader>t[',
            close = '<leader>t]',
            toggle_entry = '<leader>;',
          }
        }
      }
    }
  }
}
