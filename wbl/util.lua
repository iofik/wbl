--- Useful extensions to Lua, included globally.

_G.Class = {}

local json = require 'json'

function _G.Class:new(o)
    return setmetatable(o, { __index = self })
end

function table.merge(to, from)
    for k, v in pairs(from) do
        to[k] = v
    end
    return to
end


local function path_to_json(name)
    return system.pathForFile(name .. '.json', system.DocumentsDirectory)
end

function _G.read_json(name)
    local f = io.open(path_to_json(name), 'r')

    if not f then return end

    local text = f:read('*a')
    f:close()

    return (json.decode(text))
end

function _G.write_json(name, data)
    local f = io.open(path_to_json(name), 'w')

    if not f then return end

    f:write(json.encode(data))
    f:close()

    return true
end
