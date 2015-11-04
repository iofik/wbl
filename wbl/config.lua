local M = {}

local macros = require 'wbl.macros'

local function TemplateConfig(template, bodies, macros)
    return {
        name       = template.name,
        subject    = template.subject,
        body       = bodies[template.body],
        macros     = macros,
    }
end

local function RTConfig(rt)
    return {
        url        = rt.url:gsub('/*$', '/REST/1.0/'),
        user       = rt.user,
        password   = rt.password,
        queue      = rt.queue,
    }
end

local Sample = {
    rt = {
        url         = 'https://www.iponweb.net/rt',
        user        = 'user',
        password    = '********',
        queue       = 'notify',
    },
    templates = {
        body = {
            common  = "Sorry for inconvenience.\n",
            ill     = "I feel bad today. Will stay home.\n",
        },
        message = {
            {
                name    = "+30 minutes",
                subject = "{USER} WBL today, ETA is {TIME+30}",
                body    = 'common',
            },
            {
                name    = "+1 hour",
                subject = "{USER} WBL today, ETA is {TIME+60}",
                body    = 'common',
            },
            {
                name    = "+2 hours",
                subject = "{USER} WBL today, ETA is {TIME+120}",
                body    = 'common',
            },
            {
                name    = "ill",
                subject = "{USER} is ill",
                body    = 'ill',
            },
        },
    }
}
    
function M.parse(config=Sample)
    local rt = RTConfig(config.rt)
    local macros = macros.init{ USER = rt.user }
    local bodies = config.templates.body
    local templates = {}

    for i,template in ipairs(config.templates.message) do
        templates[i] = TemplateConfig(template, bodies, macros)
    end

    return {
        rt          = rt,
        templates   = templates,
    }
end


return M
