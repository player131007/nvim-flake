
---@type overseer.ComponentFileDefinition
return {
    desc = "Open vsplit after task has started",
    constructor = function()
        return {
            on_start = function(_, task)
                local open_vsplit = require('overseer.task_list.actions')["open vsplit"]
                if open_vsplit.condition(task) then
                    open_vsplit.run(task)
                end
            end
        }
    end
}
