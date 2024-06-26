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
      -- autoformat = false, -- `nvim-lspconfig.opts.autoformat` is deprecated. Please use `vim.g.autoformat` instead
      servers = {
        clangd = {
          root_dir = function(fname)
            return require("lspconfig.util").find_git_ancestor(fname)
          end,
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
        },
        pyright = {},
        ruff_lsp = {},
        gopls = {
          settings = {
            gopls = {
              staticcheck = false,
              gofumpt = false,
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      }
    }
  }
}
