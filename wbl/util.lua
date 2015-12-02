--- Useful extensions to Lua, included globally.

_G.Class = {}

function _G.Class:new(o)
    return setmetatable(o, { __index = self })
end
