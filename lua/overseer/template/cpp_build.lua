local overseer = require "overseer"

---@type overseer.TemplateFileDefinition
return {
    name = "cpp_build",
    builder = function()
        local file = vim.fn.expand "%:p"
        local root_dir = vim.lsp.buf.list_workspace_folders()[1]

        local status = require("overseer.constants").STATUS

        ---@type overseer.TaskDefinition
        return {
            name = "cppbuild: " .. file,

            cmd = {
                "clang++",
                "-xc++",
                "-std=c++14",
                "-I" .. root_dir,
                "-DLOCAL",
                "-D_GLIBCXX_DEBUG",
                "-D_GLIBCXX_DEBUG_PEDANTIC",
                "-Wall",
                "-Wextra",
                "-pedantic",
                "-Wconversion",
                "-fsanitize=address,undefined",
                "-pie",
                "-fno-omit-frame-pointer",
                "-fno-sanitize-recover=all",
                "-g",
                file,
                "-o",
                "/tmp/a.out",
            },

            strategy = "jobstart",
            components = {
                "on_exit_set_status",
                { "on_complete_dispose", timeout = 300, statuses = { status.FAILURE } },
                "on_result_diagnostics",
                { "on_complete_really_dispose", statuses = { status.SUCCESS, status.CANCELED } },
                "unique",
            },
        }
    end,
    tags = { overseer.TAG.BUILD },
    condition = {
        filetype = { "cpp" },
    },
}
