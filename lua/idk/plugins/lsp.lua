-- nlsp-settings
---@diagnostic disable-next-line: missing-fields
require("nlspsettings").setup {
    nvim_notify = {
        enable = true,
        timeout = 3000,
    },
}

-- lazydev.nvim
require("lazydev").setup {
    enabled = function(root)
        return not vim.uv.fs_stat(root .. "/.luarc.json")
    end,
}

-- nvim-lspconfig

-- i want my bordered window
require("lspconfig.ui.windows").default_options.border = "single"

local lspconfig = require "lspconfig"
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--header-insertion=never",
        "--header-insertion-decorators=false",
        "-j",
        "8",
        "--malloc-trim",
        "--pch-storage=memory",
    },
}

lspconfig.lua_ls.setup {}
lspconfig.nixd.setup {}
