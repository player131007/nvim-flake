vim.lsp.enable { "emmylua_ls" }

-- so treesitter injections can work
vim.api.nvim_set_hl(0, "@lsp.type.string.lua", {})
