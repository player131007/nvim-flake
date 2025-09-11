vim.keymap.set({'n', 'v'}, 'n', "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({'n', 'v'}, 'N', "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
