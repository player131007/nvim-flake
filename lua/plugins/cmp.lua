local cmp = require 'cmp'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local luasnip = require 'luasnip'
local mapping = cmp.mapping
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }
    },

    mapping = {
        ["<Esc>"] = mapping.close(),
        ["<C-f>"] = mapping.scroll_docs(4),
        ["<C-d>"] = mapping.scroll_docs(-4),
        ["<Tab>"] = mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback()
            end
        end, { 'i', 's' }),
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback()
            end
        end,
        ["<CR>"] = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then cmp.confirm()
            else fallback()
            end
        end
    }
}
