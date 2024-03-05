return {
  {
    -- 可以主动使用 lua require('Trans').install() 来主动下载，第一次下载需要较长时间，如果下载失败，可以删除 ~/.local/share/nvim/lazy/Trans.nvim 目录下的 ultimate.db ultimate.zip 之后，重新下载
    -- 安装 fstival：`sudo apt-get install festival festvox-kallpc16k`
    -- 安装 sqlite3：`sudo apt-get install sqlite3 libsqlite3-dev`
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
