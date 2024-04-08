vim.g.mapleader = ' '

local keymap = vim.keymap

keymap.set('!', '<A-Left>', '<C-Left>')
keymap.set('!', '<A-Right>', '<C-Right>')

keymap.set('n', "<leader>sh", "<cmd>split<CR>")
keymap.set('n', "<leader>sv", "<cmd>vsplit<CR>")
keymap.set('n', "<leader>nh", "<cmd>nohl<CR>")

keymap.set('n', "<C-t>", "<cmd>tabnew<CR>")
keymap.set('n', "<C-Tab>", "<cmd>tabn<CR>")
keymap.set('n', "<C-S-Tab>", "<cmd>tabp<CR>")

keymap.set('n', "[d", vim.diagnostic.goto_prev)
keymap.set('n', "]d", vim.diagnostic.goto_next)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttached", {}),
    callback = function(args)
        local opts = { buffer = args.buf }

        keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        keymap.set('n', "<F2>", vim.lsp.buf.rename, opts)
        keymap.set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set('i', "<C-k>", vim.lsp.buf.signature_help, opts)
    end
})
