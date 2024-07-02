-- nvim-treesitter
require("nvim-treesitter.configs").setup {
    auto_install = false,
    sync_install = false,
    ignore_install = {},
    ensure_installed = {},
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
}

-- nvim-treesitter-context
require("treesitter-context").setup {
    enable = true,
}
