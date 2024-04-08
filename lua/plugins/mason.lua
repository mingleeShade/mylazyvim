return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cpptools",
        "json-lsp",
        "luaformatter",
        "prettierd",
        "shfmt",
        "goimports",
        "golines"
      }
    }
  }
}
