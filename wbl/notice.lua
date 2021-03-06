local M = {}

local Notice = {}

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

local function adjust_time(time, offset) -- some empirical magic
    time = time + offset*60

    local ta_key = offset > 90 and offset % 60 == 0 and 120 or offset

    align, lean_back = unpack(TimeAlign[ta_key] or {})

    if align then
        orig_min = os.date('*t', time).min
        aligned_min = math.floor((orig_min + align - lean_back) / align) * align
        time = time + (aligned_min - orig_min) * 60
    end

    return time
end

function Notice:get_eta()
    local eta

    if self.eta then -- TODO: eta == 'prompt'
        eta = os.date('*t')
        eta.hour = self.eta.hour
        eta.min  = self.eta.min
        eta = os.time(eta)
        assert(eta > os.time(), "ETA is in the past")
    elseif self.eta_plus then
        eta = adjust_time(os.time(), self.eta_plus)
    end

    return eta
end

local function expand_macros(macros, text)
    return text:gsub('{([^{}]+)}', macros)
end

function Notice:create_ticket(rt)
    local macros = self.macros
    local eta = self:get_eta()

    if eta then
        macros = setmetatable({ ETA = os.date('%H:%M', eta) }, { __index = macros })
    end

    local subject = expand_macros(macros, self.subject)
    local body    = expand_macros(macros, self.body)

    local ticket_id = rt:create_ticket(subject, body)

    return {
        id  = ticket_id,
        eta = eta,
    }
end

local function parse_eta(eta)
    if not eta then return end

    local hour, min = eta:match('^(%d+):(%d+)$')

    if not hour then
        error("Invalid ETA string: " .. eta)
    end

    return { hour = hour, min = min }
end

function M.new(config, templates, macros)
    local template = templates[config.template]

    return setmetatable({
        name        = config.name,
        subject     = template.subject,
        body        = template.body,
        eta         = parse_eta(config.eta),
        eta_plus    = config.eta_plus,
        macros      = macros,
    }, { __index = Notice })
end

return M
