--- Useful extensions to Lua, included globally.

_G.Class = {}

function _G.Class:new(o)
    return setmetatable(o, { __index = self })
end

function table.merge(to, from)
    for k, v in pairs(from) do
        to[k] = v
    end
    return to
end
