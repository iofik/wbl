local M = {}

TimeAlign = {
    [10]  = {5, 0},
    [15]  = {5, 0},
    [20]  = {5, 0},
    [30]  = {10, 1},
    [45]  = {10, 1},
    [60]  = {15, 2},
    [90]  = {15, 2},
    [120] = {30, 4},
}

local function adjust_time(time, offset)
    time = time + offset*60
    ta_key = offset > 90 and offset % 60 == 0 and 120 or offset
    align, lean_back = unpack(TimeAlign[ta_key] or {})
    if align:
        orig_min = os.date('*t', time).min
        aligned_min = math.ceil((orig_min + align - lean_back) / align) * align
        time += (aligned_min - orig_min) * 60
    return time

local function subst_macro(macros, key):
    local value = macros[key]
    if value then return value end

    local offset = key == 'time' and 0 or tonumber(key:match('^time%+(%d+)$'))
    if offset then
        local time = adjust_time(os.time(), offset)
        return os.date('%H:%M', time)
    end
end

local function expand(self, text):
    return text:gsub('{([^{}]+)}', function(k) return subst_macro(self.macros, k) end)
end

function M.init(macros)
    return {
        macros  = macros,
        expand  = expand,
    }
end

return M
