local STATUS = require('overseer.constants').STATUS

---@type overseer.ComponentFileDefinition
return {
    desc = "Dispose task with selected statuses immediately",
    params = {
        statuses = {
            desc = "Statuses to be disposed of",
            type = "list",
            default = { STATUS.SUCCESS, STATUS.CANCELED },
            subtype = {
                type = "enum",
                choices = { STATUS.SUCCESS, STATUS.FAILURE, STATUS.CANCELED }
            }
        }
    },
    constructor = function(opts)
        local statuses = opts.statuses
        return {
            on_complete = function(_, task, status)
                if vim.tbl_contains(statuses, status) then task:dispose() end
            end
        }
    end
}
