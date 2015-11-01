import re
import requests

class RT(object):
    NewTicketTemplate = "id: ticket/new\nQueue: {queue}\nOwner: {user}\nSubject: {subject}\nText: {body}\n"
    TicketCreatedRE = re.compile('Ticket (\d+) created')

    def __init__(self, config):
        self.config = config

    def create_ticket(self, message):
        rt = self.config
        content = NewTicketTemplate.format(
            queue=rt.queue,
            user=rt.user,
            subject=message.subject,
            body=message.body.replace('\n', '\n '),
        )
        r = requests.post(rt.url+'ticket/new', auth=(rt.user, rt.password), data={'content' : content})
        m = TicketCreatedRE.search(r.text)
        return m.group(1) if m else None
