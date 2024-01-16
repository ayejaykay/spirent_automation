from ResultsManager import *
from SpirentTester import *
from WindowManager import *
#from PowerSupply import *
from LinkStatus import *
from flet import *
from dict import *
import subprocess
import threading
import atexit
import queue
import time
import os

__location__ = os.path.dirname(os.path.realpath(__file__))
kill_flag = False


# ps = PowerSupply()
# ps.on_power_supply(1, 24)

def run_tcl():
    global kill_flag
    tcl_location = "..\\Tcl\\bin\\tclsh"
    not_running = True
    data = ""
    while(1):
        if not_running:
            print("Starting Test Script")
            sp = subprocess.Popen([tcl_location, "verify_link.tcl"])
            not_running = False
        if kill_flag:
            print("Killing Subprocess")
            sp.terminate()
            sp.wait()
            break



def file_rw(z1):
    global kill_flag
    time.sleep(10)
    while(1):
        try:
            port_arr = []
            with open(f"{__location__}\\linkstatus.dat", "r") as fp:
                fp.readline()
                data = fp.readlines()
                counter = 0
                for line in data:
                    counter+=1
                    if "//" in line:
                        port_arr.append((line[6:-1]))
            port_num = 0
            for i in spirent_ports:
                if i in port_arr:
                    #print(f"{i} offline")
                    z1.set_offline(port_num)
                else:
                    #print(f"{i} online)")
                    z1.set_online(port_num)
                port_num+=1
            time.sleep(1.3)
            if kill_flag:
                break
        except FileNotFoundError:
            print("Waiting on file write")
            time.sleep(3)


def shutdown():
    global kill_flag
    global ps
    # ps.off_power_supply(1)
    kill_flag = True
    time.sleep(1)
    os.remove(f"{__location__}\\linkstatus.dat")

class ZoneOne:

    def __init__(self, page) -> None:
        self.text_a = TextField(label="Patch A", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_b = TextField(label="Patch B", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_c = TextField(label="Patch C", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_d = TextField(label="Patch D", hint_text="Scan Order Number", height=100, border_color="red")
        self.logo = Image(src=f"{__location__}\\assets\\logo.png", width=300, height=175, fit=ImageFit.CONTAIN)
        self.page = page
        self.status_bubbles = []
        self.fill_bubble_arr()
        self.port_status_row_a = Row(
            [
                self.status_bubbles[0],
                Text("//1/1"),
                self.status_bubbles[1],
                Text("//1/2"),
                self.status_bubbles[2],
                Text("//1/3"),
                self.status_bubbles[3],
                Text("//1/4"),
                self.status_bubbles[4],
                Text("//1/5"),
                self.status_bubbles[5],
                Text("//1/6"),   
                self.status_bubbles[6],
                Text("//1/7"),
                self.status_bubbles[7],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_b = Row(
            [
                self.status_bubbles[8],
                Text("//1/1"),
                self.status_bubbles[9],
                Text("//1/2"),
                self.status_bubbles[10],
                Text("//1/3"),
                self.status_bubbles[11],
                Text("//1/4"),
                self.status_bubbles[12],
                Text("//1/5"),
                self.status_bubbles[13],
                Text("//1/6"),   
                self.status_bubbles[14],
                Text("//1/7"),
                self.status_bubbles[15],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_c = Row(
            [
                self.status_bubbles[16],
                Text("//1/1"),
                self.status_bubbles[17],
                Text("//1/2"),
                self.status_bubbles[18],
                Text("//1/3"),
                self.status_bubbles[19],
                Text("//1/4"),
                self.status_bubbles[20],
                Text("//1/5"),
                self.status_bubbles[21],
                Text("//1/6"),   
                self.status_bubbles[22],
                Text("//1/7"),
                self.status_bubbles[23],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_d = Row(
            [
                self.status_bubbles[24],
                Text("//1/1"),
                self.status_bubbles[25],
                Text("//1/2"),
                self.status_bubbles[26],
                Text("//1/3"),
                self.status_bubbles[27],
                Text("//1/4"),
                self.status_bubbles[28],
                Text("//1/5"),
                self.status_bubbles[29],
                Text("//1/6"),   
                self.status_bubbles[30],
                Text("//1/7"),
                self.status_bubbles[31],
                Text("//1/8"),
            ],
            spacing=5,
        )

    def fill_bubble_arr(self):
        for i in range(32):
            self.status_bubbles.append(Icon(name=icons.CIRCLE_OUTLINED, color=colors.BLACK))

    def set_online(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_ROUNDED
        self.status_bubbles[index].color = colors.GREEN
        self.page.update()

    def set_offline(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_OUTLINED
        self.status_bubbles[index].color = colors.BLACK
        self.page.update()


    def build_zone_1(self):
        return Column(
                [
                Container(
                    content=Column(
                      controls=[
                          self.port_status_row_a,
                          self.text_a,
                          self.port_status_row_b,
                          self.text_b,
                          self.port_status_row_c,
                          self.text_c,
                          self.port_status_row_d,
                          self.text_d,
                        #   Container(
                        #       content=Column(
                        #           controls=[
                        #               self.logo
                        #           ]
                        #       ),
                        #       width=self.page.window_width/3,
                        #       height=175,
                        #       alignment=alignment.center_left,
                        #       bgcolor="red"
                        #   )
                      ],
                      spacing=0,
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.65,
                    padding=padding.only(top=10),
                    # bgcolor="black",
                   ),
                Container(
                    content=Column(
                        controls=[
                            self.logo
                        ]
                    ),
                    width=self.page.window_width/3,
                    height=175,
                    alignment=alignment.top_left,
                    # bgcolor="red"
                )
                ],
                expand=True
                # wrap=True,
        )
    



class ZoneTwo:

    def __init__(self, page) -> None:
        self.page = page
        self.lv = ListView(expand=1, spacing=10, auto_scroll=True)
        

    def build_zone_2(self):
        return Column(
                [
                Container(
                    content=Column(
                        [
                            Container(
                                content=Column(
                                    controls=[
                                        self.lv
                                    ],
                                ),
                                bgcolor=colors.GREY_100,
                                padding=10,
                                width=(self.page.window_width/2)*0.9,
                                height=(self.page.window_height*0.66), 
                                alignment=alignment.center,
                                border_radius=20,
                                # border=border.all(1, "red")
                                shadow=BoxShadow(
                                    spread_radius=1,
                                    blur_radius=15,
                                    color=colors.RED_100,
                                    blur_style=ShadowBlurStyle.OUTER
                                )
                            ),
                        ]
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.66,
                    alignment=alignment.center,
                    padding=padding.only(right=40, top=10),
                    #bgcolor="green"
                ), 
                ],
                # expand=True
        )
    
class ZoneThree:

    def __init__(self, page, classname, window) -> None:
        self.page = page
        self.window = window
        self.class_name = classname
        self.window_manager = WindowManager(self.window, self.page)
        self.spirent_tester = SpirentTester()
        self.results_manager = ResultsManager()
        #self.start_proc()
        self.test_btn =  ElevatedButton(
                            style=ButtonStyle(
                                bgcolor={
                                    MaterialState.HOVERED: colors.RED_200,
                                    MaterialState.FOCUSED: colors.RED_200,
                                    MaterialState.DEFAULT: colors.RED_50
                                },
                                color={
                                    MaterialState.DEFAULT: colors.RED
                                },
                                overlay_color={
                                    MaterialState.DEFAULT: colors.RED_200
                                },
                                elevation={
                                    "pressed": 0,
                                    "": 10,
                                }
                            ),
                            text="Start Spirent Test", 
                            width=300, 
                            height=100, 
                            on_click=self.btn_click,
                            #color="red", 
                            #bgcolor=colors.GREY_50
                        )

   
    def start_proc(self):
        global kill_flag
        kill_flag = False
        t1 = threading.Thread(target=run_tcl, daemon=True).start()
        t2 = threading.Thread(target=file_rw, args=(self.class_name,), daemon=True).start()
        print("Threads started")

    def btn_click(self, e):
        global kill_flag
        print("Killing status processes")
        kill_flag = True
        self.test_btn.text="TESTING"
        #self.ps.on_power_supply(1, 24)
        time.sleep(3)

        var_arr = [self.class_name.text_a, self.class_name.text_b, self.class_name.text_c, self.class_name.text_d]
        valid_fields = []

        for i in var_arr:

            if i.value=="":
                pass
            else:
                valid_fields.append(i)


       

        self.page.update()
        arr = []
        try:
            for i in valid_fields:
                arr = self.spirent_tester.test_device(i.label, i.value, self.window_manager)
                for j in arr:
                    self.window_manager.write_message_to_window(j)
                self.results_manager.transmit_data(arr, i.label, i.value)
                arr = []
        except TypeError:
            pass

        #self.ps.off_power_supply(1)

        self.test_btn.text="Start Spirent Test"
        self.page.update()
        self.start_proc()

    def build_zone_3(self):
        return Column(
                [
                Container(
                    content=Column(
                        [
                            Container(
                                content=Column(
                                    controls=[
                                        self.test_btn,
                                    ]
                                ),
                                width=300,
                                height=100, 
                                # bgcolor="black",
                                alignment=alignment.center,
                                # padding=40
                                padding=padding.only(top=5)
                            ),
                        ],
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.25,
                    # bgcolor="blue",
                    alignment=alignment.center,
                    padding=padding.only(right=20, top=30)
                ),
                ],
                # expand=True
            # wrap=True,
        )




def main(page: Page):
    page.title = "Spirent Automation"

    z1 = ZoneOne(page)
    z2 = ZoneTwo(page)
    z3 = ZoneThree(page, z1, z2.lv)
   
    page.add(
        Row(
        [
        z1.build_zone_1(),
        Column(
            [
            z2.build_zone_2(),
            z3.build_zone_3(),
            ],
        ),
        ],
        expand=True,
        )
    )

    page.update()
    atexit.register(shutdown)


if __name__ == "__main__":
    app(target=main)
