from macro import Macros

class MessageConfig(object):
    __slots__ = ['name', 'subject', 'body', 'macros']
    def __init__(self, message, bodies, macros):
        self.name       = message['name']
        self.subject    = message['subject']
        self.body       = bodies[message['body']]
        self.macros     = macros

class RTConfig(object):
    __slots__ = ['url', 'user', 'password', 'queue']
    def __init__(self, rt):
        self.url        = rt['url']
        self.user       = rt['user']
        self.password   = rt['password']
        self.queue      = rt['queue']

class Config(object):
    Sample = {
        'rt' : {
            'url' : 'https://www.iponweb.net/rt/REST/1.0/',
            'user' : 'viofik',
            'password' : '********',
            'queue' : 'notify',
        },
        'templates' : {
            'body' : {
                'common' : "Sorry for inconvenience.\n",
                'ill' : "I feel bad today. Will stay home.\n",
            },
            'message' : [
                {
                    'name' : "30 minutes",
                    'subject' : "{USER} WBL today, ETA is {TIME+30}",
                    'body' : 'common',
                },
                {
                    'name' : "1 hour",
                    'subject' : "{USER} WBL today, ETA is {TIME+60}",
                    'body' : 'common',
                },
                {
                    'name' : "2 hours",
                    'subject' : "{USER} WBL today, ETA is {TIME+120}",
                    'body' : 'common',
                },
                {
                    'name' : "ill",
                    'subject' : "{USER} is ill",
                    'body' : 'ill',
                },
            ],
        }
    }
    
    def __init__(self, config=Sample):
        self.rt = RTConfig(config['rt'])

        bodies = config['templates']['body']
        messages = config['templates']['message']
        macros = Macros({ 'USER' : self.rt.user })

        self.messages = [ MessageConfig(msg, bodies, macros) for msg in messages ]
