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
trouble.setup {
    focus = true,
    auto_jump = true,
    preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
    },
    modes = {
        buffer_diagnostics = {
            mode = "diagnostics",
            filter = { buf = 0 }
        }
    }
}
keymap.set("n", "<leader>xx", function() trouble.toggle "diagnostics" end)
keymap.set("n", "<leader>xd", function() trouble.toggle "buffer_diagnostics" end)
keymap.set("n", "<leader>gd", function() trouble.toggle "lsp_definition" end)
keymap.set("n", "<leader>gr", function() trouble.toggle "lsp_references" end)

-- luasnip
require("luasnip.config").set_config {
    update_events = { "TextChanged", "TextChangedI" }
}
require("luasnip.loaders.from_lua").load()

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
