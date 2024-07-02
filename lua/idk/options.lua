local opt = vim.opt

opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.splitright = true
opt.splitbelow = true

opt.wrap = false

opt.list = true
opt.listchars = {
    multispace = "‣···",
    tab = "‣ ",
    trail = "·",
}

opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("help_relnumber", {}),
    callback = function()
        if vim.bo.filetype == "help" then
            vim.opt_local.relativenumber = true
        end
    end,
    desc = "Enable relative line number for help files",
})

vim.cmd.aunmenu "PopUp"
