return {
  {
    "mhartington/formatter.nvim",
    opts = {
      -- Utilities for creating configurations
      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- lua 的格式化，可以由 coc-sumneko-lua 支持
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
          -- "formatter.filetypes.lua" defines default configurations for the
          -- "lua" filetype
          -- require("formatter.filetypes.lua").stylua,

          -- You can also define your own configuration
          function()
            -- Supports conditional formatting
            -- print("trigger lua format")
            local util = require("formatter.util")
            if util.get_current_buffer_file_name() == "special.lua" then
              return nil
            end

            -- Full specification of configurations is down below and in Vim help
            -- files
            local get_opts = {}
            get_opts["buf"] = 0
            local indent_width = vim.api.nvim_get_option_value("tabstop", get_opts)
            return {
              exe = "lua-format",
              args = {
                "--indent-width=" .. indent_width,
                "--column-limit=150",
                "--no-spaces-inside-functiondef-parens",
                "--no-spaces-inside-functioncall-parens",
                "--chop-down-parameter",
                "--align-table-field",
                "--chop-down-table",
                "--no-keep-simple-control-block-one-line",
                "--no-keep-simple-function-one-line",
                util.escape_path(util.get_current_buffer_file_path())
              },
              stdin = true
            }
          end
        },
        html = {
          function()
            return require("formatter.filetypes.html").prettier()
          end
        },
        css = {
          function()
            return require("formatter.filetypes.css").prettier()
          end
        },
        javascript = {
          function()
            return require("formatter.filetypes.javascript").prettier()
          end
        },
        python = {
          function()
            return require("formatter.filetypes.python").black()
          end
        },
        cpp = {
          -- require("formatter.filetypes.cpp").clangformat,
          function()
            local Util = require("lazyvim.util")
            local root_path = Util.get_root()
            -- print(vim.fn.filereadable(vim.fn.expand(root_path .. "/.astylerc")))
            if vim.fn.filereadable(vim.fn.expand(root_path .. "/.astylerc")) == 1 then
              return {exe = "astyle", args = {"--options=" .. root_path .. "/.astylerc"}, stdin = true}
            elseif vim.fn.filereadable(vim.fn.expand(root_path .. "/.clang-format")) == 1 then
              -- print("use clang-format")
              local util = require("formatter.util")
              return {
                exe = "clang-format",
                args = {"-style=file", "-assume-filename", util.escape_path(util.get_current_buffer_file_name())},
                stdin = true
              }
            else
              -- print("else")
              return {exe = "astyle", args = {"--options=$HOME/.config/nvim/.astylerc"}, stdin = true}
            end
          end
        },
        markdown = {
          function()
            return require("formatter.filetypes.markdown").prettier()
          end
        }

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        -- ["*"] = {
        --   -- "formatter.filetypes.any" defines default configurations for any
        --   -- filetype
        --   require("formatter.filetypes.any").remove_trailing_whitespace,
        -- },
      }
    }
  }
}
