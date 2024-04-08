local uv = vim.loop

---@type overseer.ComponentFileDefinition
return {
    desc = "Notify the task's duration after it completes",
    constructor = function()
        return {
            on_start = function(self)
                self.start_time = uv.now()
            end,

            ---@param task overseer.Task
            on_complete = function(self, task)
                local duration = uv.now() - self.start_time

                vim.notify(
                    string.format("Time elapsed: %.3fs", duration/1000),
                    vim.log.levels.INFO,
                    {
                        title = task.name
                    }
                )
            end,
        }
    end
}
