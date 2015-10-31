#!/usr/bin/env python

import kivy
kivy.require('1.8.0')

from kivy.app import App
from kivy.uix.gridlayout import GridLayout
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.textinput import TextInput

from config import Config


class MainScreen(GridLayout):
    def __init__(self, actions, **kwargs):
        super(MainScreen, self).__init__(**kwargs)
        self.cols = 3
        self.buttons = []
        for action in actions:
            button = Button(text=action['title'])
            self.buttons.append(button)
            self.add_widget(button)

class WBLApp(App):
    def build(self):
        return MainScreen([
            { "title" : "30 min" },
            { "title" : "1 hour" },
            { "title" : "2 hours" },
            { "title" : "ill" },
            { "title" : "drunk" },
        ])

if __name__ == '__main__':
    WBLApp().run()
