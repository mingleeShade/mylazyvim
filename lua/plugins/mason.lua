return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cpptools",
        "json-lsp",
        "luaformatter",
        "prettier",
        "prettierd",
        "shfmt",
        "goimports",
        "golines"
      }
    }
  }
}
