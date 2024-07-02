local uv = vim.uv

local function get_effective_line_count(bufnr)
    local count = vim.api.nvim_buf_line_count(bufnr)
    for i = count, 1, -1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, true)[1]
        if line ~= "" then
            return i
        end
    end
    return 0
end

---@type overseer.ComponentFileDefinition
return {
    desc = "Used for cpp_run template",
    constructor = function()
        return {
            on_start = function(self, task)
                local open_vsplit = require("overseer.task_list.actions")["open vsplit"]
                if open_vsplit.condition(task) then
                    open_vsplit.run(task)
                end

                self.start_time = uv.now()
            end,

            on_exit = function(self, task)
                local duration = uv.now() - self.start_time
                local bufnr = task:get_bufnr()

                local line_count = get_effective_line_count(bufnr)

                vim.bo[bufnr].modifiable = true
                vim.api.nvim_buf_set_lines(
                    bufnr,
                    line_count,
                    line_count,
                    true,
                    { string.format("[Time elapsed: %.3fs]", duration / 1000) }
                )
                vim.bo[bufnr].modifiable = false
            end,
        }
    end,
}
