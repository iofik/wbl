local M = {}

local function expand(self, text):
    return text:gsub('{([^{}]+)}', self.macros)
end

function M.new(macros)
    return {
        macros  = macros,
        expand  = expand,
    }
end

return M
