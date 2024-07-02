local overseer = require "overseer"

---@type overseer.TemplateFileDefinition
return {
    name = "cpp_run",
    builder = function()
        local file = vim.fn.expand "%:p"

        ---@type overseer.TaskDefinition
        return {
            name = "cpprun: " .. file,

            cmd = { "/tmp/a.out" },

            env = {
                ASAN_OPTIONS = "detect_leaks=0",
            },

            strategy = "terminal",

            components = {
                { "dependencies", task_names = { "cpp_build" } },
                "on_exit_set_status",
                { "on_complete_dispose", timeout = 120 },
                "unique",
                "cpp_run",
            },
        }
    end,

    tags = { overseer.TAG.RUN },
    condition = {
        filetype = { "cpp" },
    },
}
