-- neodev
require("neodev").setup {
    setup_jsonls = false,

    ---@param root_dir string
    ---@param library table
    override = function(root_dir, library)
        if root_dir:find(vim.fn.expand('~').."/nvim-flake", 1, true) == 1 then
            library.enabled = true
            library.runtime = true
            library.types = true
            library.plugins = true
        end
    end
}

-- nvim-lspconfig

-- i want my bordered window
require('lspconfig.ui.windows').default_options.border = "single"

local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)
local lspconfig = require "lspconfig"

lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--header-insertion=never",
        "--header-insertion-decorators=false",
        "-j", "8",
        "--malloc-trim",
        "--pch-storage=memory",
    },
    capabilities = capabilities
}

lspconfig.lua_ls.setup {
    capabilities = capabilities
}

lspconfig.nil_ls.setup {
    capabilities = capabilities
}
