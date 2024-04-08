local plugins = {
    "misc",
    "treesitter",
    "lsp",
    "cmp",
    "overseer",
}

for _, plug in ipairs(plugins) do
    require('plugins.' .. plug)
end
