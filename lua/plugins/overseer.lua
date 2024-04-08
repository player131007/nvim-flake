local overseer = require "overseer"

---@diagnostic disable-next-line: missing-fields
overseer.setup {
    templates = { "cpp_build", "cpp_run" },
}

vim.keymap.set({ "n", "i" }, "<F9>", function() vim.cmd [[
    write
    OverseerRun cpp_run
]] end)

vim.keymap.set('n', "<leader>op", "<cmd>OverseerOpen<CR>")
