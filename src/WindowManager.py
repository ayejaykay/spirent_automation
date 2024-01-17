from flet import Page, Text, ProgressBar

class WindowManager:

    def __init__(self, WindowRef, page):
        self.WindowRef = WindowRef
        self.page = page
        self.progress_text = Text("Testing...")
        self.progress_bar = ProgressBar(width=200, color="red", bgcolor="#eeeeee")

    def write_message_to_window(self, msg):
        self.WindowRef.controls.append(Text(msg))
        self.page.update()

    def start_progress_bar(self):
        self.WindowRef.controls.append(self.progress_text)
        self.WindowRef.controls.append(self.progress_bar)
        self.page.update()

    def stop_progress_bar(self):
        self.WindowRef.controls.pop()
        self.WindowRef.controls.pop() # Running pop twice should get rid of both the text and progress bar
        self.page.update()