local M = {}

local notice = require 'wbl.notice'
local rt = require 'wbl.rt'

local DefaultConfig = {
    rt = {
        url         = 'https://www.iponweb.net/rt',
        user        = 'user',
        password    = '********',
        queue       = 'notify',
    },
    templates = {
        wbl = {
            subject     = "{USER} WBL today, ETA is {ETA}",
            body        = "Sorry for inconvenience.\n",
        },
        ill = {
            subject     = "{USER} is ill",
            body        = "I feel bad today. Will stay home.\n",
        },
    },
    notices = {
        {
            name        = "+30 minutes",
            template    = 'wbl',
            eta_plus    = 30,
        },
        {
            name        = "+1 hour",
            template    = 'wbl',
            eta_plus    = 60,
        },
        {
            name        = "+2 hours",
            template    = 'wbl',
            eta_plus    = 120,
        },
        {
            name        = "15:00",
            template    = 'wbl',
            eta         = '15:00',
        },
        {
            name        = "ill",
            template    = 'ill',
        },
    }
}

local current

local function parse(config)
    local rt = rt.new(config.rt)
    local macros = { USER = rt.user }
    local notices = {}

    for i, notice_cfg in ipairs(config.notices) do
        notices[i] = notice.new(notice_cfg, config.templates, macros)
    end

    return {
        rt      = rt,
        notices = notices,
    }
end

function M.read()
    if not current then
        current = read_json('config') or DefaultConfig
    end

    return current
end

function M.write()
    if not write_json('config', current) then
        error("Cannot save configuration")
    end
end

function M.get()
    return parse(M.read())
end

return M
