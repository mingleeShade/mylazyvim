-- 文档 https://bytedance.larkoffice.com/docx/QElUdgFmaovaAcxmYfnc4PyhnCh
return {
    "https://code.byted.org/chenjiaqi.cposture/codeverse.vim.git",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        require("trae").setup({
        })
    end
}
