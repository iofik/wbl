#!/usr/bin/env python

import kivy
kivy.require('1.8.0')

from kivy.app import App
from kivy.uix.stacklayout import StackLayout
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.textinput import TextInput

from config import Config
from message import MessageBuilder


class MainScreen(StackLayout):
    def __init__(self, config, **kwargs):
        super(MainScreen, self).__init__(**kwargs)
        self.orientation = 'rl-bt'
        self.buttons = []
        for message in config.messages:
            button = Button(text=message.name, size_hint=(1./3, 1./6))
            self.buttons.append(button)
            self.add_widget(button)

class WBLApp(App):
    def build(self):
        return MainScreen(Config())

if __name__ == '__main__':
    WBLApp().run()
