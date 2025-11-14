return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  -- Not all LSP servers add brackets when completing a function.
  -- To better deal with this, LazyVim adds a custom option to cmp,
  -- that you can configure. For example:
  --
  -- ```lua
  -- opts = {
  --   auto_brackets = { "python" }
  -- }
  -- ```
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<tab>"] = function(fallback)
          return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
        end,
      }),

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name ="trae"},
        { name = "luasnip" },
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }, {
      }),
      formatting = {
        format = function(entry, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end,
      },
      experimental = {
        -- only show ghost text when we show ai completions
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
      sorting = defaults.sorting,
    }
  end,
  main = "lazyvim.util.cmp",
}
-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     version = false,
--     event = "InsertEnter",
--     dependencies = {
--       "hrsh7th/cmp-emoji",
--     },
--     opts = function(_, opts)
--       -- 清空默认 sources，由自己配置
--       opts.sources = {}
--       -- insert 顺序决定展示顺序，数组末尾的展示在后
--       -- group_index 决定是否为同组，当同组都没有补全项，下一组进行兜底展示
--       -- trae 排在首位
--
--       local luasnip = require("luasnip")
--       local cmp = require("cmp")
--
--       table.insert(opts.sources, {
--         name = 'trae',
--         group_index = 1,
--       })
--       table.insert(opts.sources, {
--         name ='luasnip',
--         group_index = 1,
--       })
--       -- 继续添加其他 source ...
--
--       -- 开启类似 copilot 一样的虚拟文本
--       table.insert(opts.experimental, {
--         ghost_text = true,
--       })
--
--       local has_words_before = function()
--         unpack = unpack or table.unpack
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--       end
--
--       opts.mapping = vim.tbl_extend("force", opts.mapping, {
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--             -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--             -- this way you will only jump inside the snippet region
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           elseif has_words_before() then
--             cmp.complete()
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--       })
--     end,
--     -- ---@param opts cmp.ConfigSchema
--     -- opts = function(_, opts)
--     --   local has_words_before = function()
--     --     unpack = unpack or table.unpack
--     --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     --   end
--     --
--     --   local luasnip = require("luasnip")
--     --   local cmp = require("cmp")
--     --
--     --   opts.mapping = vim.tbl_extend("force", opts.mapping, {
--     --     ["<Tab>"] = cmp.mapping(function(fallback)
--     --       if cmp.visible() then
--     --         cmp.select_next_item()
--     --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--     --         -- this way you will only jump inside the snippet region
--     --       elseif luasnip.expand_or_jumpable() then
--     --         luasnip.expand_or_jump()
--     --       elseif has_words_before() then
--     --         cmp.complete()
--     --       else
--     --         fallback()
--     --       end
--     --     end, {
--     --       "i",
--     --       "s",
--     --     }),
--     --     ["<S-Tab>"] = cmp.mapping(function(fallback)
--     --       if cmp.visible() then
--     --         cmp.select_prev_item()
--     --       elseif luasnip.jumpable(-1) then
--     --         luasnip.jump(-1)
--     --       else
--     --         fallback()
--     --       end
--     --     end, {
--     --       "i",
--     --       "s",
--     --     }),
--     --   })
--     -- end,
--   },
-- }
