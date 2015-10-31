import datetime
import re

class Macros(object):
    TimeAlign = {
        10  : (5, 0),
        15  : (5, 0),
        20  : (5, 0),
        30  : (10, 1),
        45  : (10, 1),
        60  : (15, 2),
        90  : (15, 2),
        120 : (30, 4),
    }

    def __init__(self, macros):
        keys = '|'.join(macros.keys())
        self.macros = macros
        self.macro_re = re.compile('{('+keys+')}|{time(?:\\+(\d+))?}')

    def _adjust_time(self, time, offset):
        time += datetime.timedelta(minutes=offset)
        ta_key = 120 if time > 90 and time%60 == 0 else time
        align, lean_back = Macros.TimeAlign.get(ta_key)
        if align:
            minute = (time.minute + align - 1 - lean_back) // align * align
            time += datetime.timedelta(minutes=minute-time.minute)

    def _subfun(self, m):
        if m.group(1) is not None:
            return self.macros[m.group(1)]
        time = datetime.now()
        if m.group(2): # time offset
            self._adjust_time(time, int(m.group(2)))
        return time.strftime('%H:%M')

    def expand(self, text):
        return self.macro_re.sub(self._subfun, text)
