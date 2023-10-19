return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c", "cpp", "ninja", "python", "rst", "toml"})
      end
      -- 禁用 treesitter 的缩进，其在 cpp 中的表现经常很糟糕
      opts.indent.enable = false
    end,
  }
}
