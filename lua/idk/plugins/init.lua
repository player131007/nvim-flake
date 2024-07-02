local plugins = {
    "misc",
    "treesitter",
    "lsp",
    "cmp",
    "overseer",
}

for _, plug in ipairs(plugins) do
    require('idk.plugins.' .. plug)
end
