return {
  {
    -- 可以主动使用 lua require('Trans').install() 来主动下载
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
        default = {
          title = vim.fn.has 'nvim-0.9' == 1 and {
            {'',         'TransTitleRound'},
            {'󰊿 Trans',   'TransTitle'},
            {'',         'TransTitleRound'},
          },
        },
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
