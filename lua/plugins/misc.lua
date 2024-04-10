local keymap = vim.keymap

-- nvim-notify
vim.notify = require "notify"

-- lualine
require('lualine').setup {
    options = {
        theme = 'base16',
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        disabled_filetypes = { "Trouble" }
    }
}

-- nvim-autopairs
require('nvim-autopairs').setup {
    check_ts = true,
    map_c_h = true
}

-- trouble.nvim
local trouble = require 'trouble'
keymap.set('n', "<leader>xd", function() trouble.toggle "document_diagnostics" end)
keymap.set('n', "<leader>gr", function() trouble.toggle "lsp_references" end)
keymap.set('n', "<leader>gd", function() trouble.toggle "lsp_definitions" end)
keymap.set('n', "<leader>gi", function() trouble.toggle "lsp_implementations" end)
keymap.set('n', "<leader>td", function() trouble.toggle "lsp_type_definitions" end)

-- luasnip
require("luasnip.config").set_config {
    update_events = { "TextChanged", "TextChangedI" }
}
require("luasnip.loaders.from_lua").load()

-- comment.nvim
require("Comment").setup()

-- hardtime.nvim
require("hardtime").setup {
    restricted_keys = {
        ["<Up>"] = { "n", "x" },
        ["<Down>"] = { "n", "x" },
        ["<Left>"] = { "n", "x" },
        ["<Right>"] = { "n", "x" }
    },
    disable_mouse = false,
    disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {}
    },
    max_count = 5
}
