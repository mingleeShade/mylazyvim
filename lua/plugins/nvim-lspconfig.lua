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
      autoformat = false
    }
  }
}
