vim.g.mapleader = ' '

vim.o.termguicolors = true

vim.o.winborder = "rounded"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false

vim.o.breakindent = true

vim.o.signcolumn = "yes"

vim.o.timeoutlen = 200

vim.o.cursorline = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
-- TODO: replace with vim.o
vim.opt.listchars = {
    trail = '·',
    nbsp = '␣'
}

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
