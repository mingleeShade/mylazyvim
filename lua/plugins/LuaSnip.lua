return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "molleweide/LuaSnip-snippets.nvim",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    keys = function()
      return {}
    end,
  },
}
