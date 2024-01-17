from flet import Page, Text

class WindowManager:

    def __init__(self, WindowRef, page):
        self.WindowRef = WindowRef
        self.page = page

    def write_message_to_window(self, msg):
        self.WindowRef.controls.append(Text(msg))
        self.page.update()
