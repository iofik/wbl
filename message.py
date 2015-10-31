class Message(object):
    __slots__ = ['subject', 'body']
    def __init__(self, subject, body):
        self.subject = subject
        self.body = body

class MessageBuilder(object):
    def __init__(self, config):
        self.config = config

    def generate(self):
        subject = self.config.macros.expand(self.config.subject)
        body = self.config.macros.expand(self.config.body)
        return Message(subject, body)
