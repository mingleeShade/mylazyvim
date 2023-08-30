return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      for k, v in pairs(keys) do
        local kmap = v
        if kmap["desc"] == "Format Document" then
          keys[k] = {"<leader>cf", "<cmd>Format<cr>", desc = "Format Document(s)", has = "formatting"}
        elseif kmap["desc"] == "Format Range" then
          keys[k] = {"<leader>cf", "<cmd>Format<cr>", desc = "Format Range(s)", mode = "v", has = "rangeFormatting"}
        end
      end
    end,
    opts = {
      -- Close autoformat, use formatter.nvim to format
      autoformat = false,
      servers = {
        -- Ensure mason installs the server
        clangd = {
          keys = {{"<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)"}},
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("Makefile", "configure.ac", "configure.in", "config.h.in", "meson.build",
                                                          "meson_options.txt", "build.ninja")(fname) or
                       require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or
                       require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {offsetEncoding = {"utf-16"}},
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders"
          },
          init_options = {usePlaceholders = true, completeUnimported = true, clangdFileStatus = true}
        }
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, {server = opts}))
          return true
        end
      }
    }
  }
}
