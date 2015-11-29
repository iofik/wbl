local M = {}

local RT = {}

function RT:create_ticket(subject, body)
    return 123456 -- TODO
end

function RT:update_ticket(id, body)
    -- TODO
end

function RT:resolve_ticket(id, body)
    -- TODO
end

function M.new(config)
    return setmetatable({
        url         = config.url:gsub('/*$', '/REST/1.0/'),
        user        = config.user,
        password    = config.password,
        queue       = config.queue,
    }, { __index = RT })
end

return M
