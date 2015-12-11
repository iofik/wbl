local M = {}

local current = read_json('status')

function M.get()
    return current
end

function M.set(ticket)
    current = ticket
    if not write_json('status', ticket) then
        error("Cannot save configuration")
    end
end

return M
