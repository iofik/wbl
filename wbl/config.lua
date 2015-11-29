local M = {}

local Notice = require 'wbl.notice'
local RT = require 'wbl.rt'

local Sample = {
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
    
function M.parse(config=Sample)
    local rt = RT.new(config.rt)
    local macros = { USER = rt.user }
    local notices = {}

    for i, notice in ipairs(config.notices) do
        notices[i] = Notice.new(notice, config.templates, macros)
    end

    return {
        rt      = rt,
        notices = notices,
    }
end


return M
