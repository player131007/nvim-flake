vim.opt.runtimepath:append(require('nvim-treesitter.install').get_package_path('runtime'))

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("AutoTreesitter", { clear = true }),
  desc = "Automatically enable treesitter if available",
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end
  end
})
