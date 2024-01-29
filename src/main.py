from ResultsManager import *
from SpirentTester import *
from WindowManager import *
from PowerSupply import *
from dict import *
import subprocess
import threading
import logging
import argparse
import atexit
import queue
import time
import sys
import os

try:
    from flet import *
except ImportError:
    os.system("pip install flet")

__location__ = os.path.dirname(os.path.realpath(__file__)) # Path to current working directory where app is running from

parser = argparse.ArgumentParser("Spirent Automation Debug")

parser.add_argument('-d', '--debug', action='store_true')

args = parser.parse_args()

yellow = "\x1b[33;20m"
red = "\x1b[31;20m"
reset = "\x1b[0m"

# global test_kill_flag

kill_flag = False # Kills TCC polling function that checks which ports are online
restart_flag = False # Restarts the polling script once we reach the subscription error from spirent.  max is 32 

ps = PowerSupply() # Inititalizes the power supply when the application starts
ps.on_power_supply(1, 24) # Turns on the power supply to 24VDC right after initialization

########################### run_tcl() ##########################
# Description:                                                 #
#   - Handles the thread which starts and stops the script     #
#     which polls the Spirent ports to notify whether or not   #
#     they are the Spirent ports to notify whether or not they #
#     are the Spirent ports to notify whether or not they are  #
#     online.                                                  #
# Params:                                                      #
#   - None                                                     #
# Returns:                                                     #
#   - None                                                     #
#                                                              #
# Notes:                                                       #
#   - kill_flag is set during shutdown and button click        #
#   - restart_flag is set when file_rw reads subscription err  #
################################################################

def run_tcl():
    global kill_flag
    global restart_flag
    tcl_location = "..\\Tcl\\bin\\tclsh" # Path to tclsh.exe 
    not_running = True
    while(1):
        if not_running:
            print("Starting Test Script")
            sp = subprocess.Popen([tcl_location, "verify_link.tcl"]) # Tcl script to verify online ports
            not_running = False
        if kill_flag:
            print("Killing Subprocess")
            sp.terminate()
            sp.wait()
            break
        if restart_flag:
            print("Killing Subprocess")
            sp.terminate()
            sp.wait()
            not_running = True # Set to true so that the subprocess starts again
            restart_flag = False

       
########################## file_rw() #########################
# Description:                                               #
#   - Reads from linkstatus.dat which is written to by       #
#     verify_link.tcl which checks whether the port is       #
#     online or offline.  This function will also call the   #
#     functions which toggle the port status elements on the #
#     UI.                                                    #
# Params:                                                    #
#   - z1: Reference to the ZoneOne class where the port      #
#         status elements are.                               #
# Returns:                                                   #
#   - None                                                   #
##############################################################


def file_rw(z1):
    global kill_flag
    global restart_flag
    time.sleep(5)
    while(1):
        try:
            port_arr = []
            with open(f"{__location__}\\linkstatus.dat", "r+") as fp: # File created by verify_link.tcl
                fp.readline() # Skip the first line
                data = fp.readlines() # Read the rest of the file
                counter = 0 # Index for traversing each line individually 
                for line in data: 
                    counter+=1
                    if "//" in line: # Info written to file shows which ports are offline.  We are looking for the // which starts the port ID
                        port_arr.append((line[6:-1]))
                    elif "SubscriptionError" in line: # This error is printed to file if we hit max subscriptions in verify_link.tcl
                        restart_flag = True # If we hit the max subscriptions, we want to kill the script and restart it
            if restart_flag:
                os.remove(f"{__location__}\\linkstatus.dat")
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

#################### shutdown ####################
# Description:  Turns off anything running as a  #
#               result of the application. Any   #
#               thread and the power supply when #
#               the user exits the application.  #
#               Defined in main() with           #
#               atexit.register                  #
# Params:                                        #
#   - None                                       #
# Returns:                                       #
#   - None                                       #
##################################################

def shutdown():
    global kill_flag
    global ps
    ps.off_power_supply(1)
    time.sleep(1)
    kill_test()
    time.sleep(1)
    kill_flag = True
    time.sleep(1)
    try:
        os.remove(f"{__location__}\\linkstatus.dat")
    except FileNotFoundError:
        pass

###################### ZoneOne ######################
# Description: UI zone which coveres the text boxes #
#              and the logo in bottom left corner.  #
# Params:                                           #
#   - page: Reference to Flet page object           #
# Returns:                                          #
#   - Class reference                               #
#####################################################

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

    ##################### fill_bubble_array() #####################
    # Description:  The port status bubbles are identified using  #
    #               an array, where each port address corresponds #
    #               to an index in an array. The index for each   #
    #               is static, and set by the "spirent_ports"     #
    #               dictionary in dict.py.  We will read the port #
    #               as "//10.11.3.1/X/Y" which will map to an     #
    #               index which correspond to that object on the  #
    #               UI.                                           #
    # Params:                                                     #
    #   - None                                                    #
    # Returns:                                                    #
    #   - None                                                    #
    ###############################################################

    def fill_bubble_arr(self):
        for i in range(32):
            self.status_bubbles.append(Icon(name=icons.CIRCLE_OUTLINED, color=colors.BLACK))

    ######################## set_online() #########################
    # Description:  Turns the port green if it is online when the #
    #               function is called in file_rw().              #
    # Params:                                                     #
    #   - index:    value obtained from "spirent_ports" list that #
    #               maps port string to array index.              #
    # Returns:                                                    #
    #   - None                                                    #
    ###############################################################

    def set_online(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_ROUNDED
        self.status_bubbles[index].color = colors.GREEN
        self.page.update()

    ######################## set_offline() #########################
    # Description:  Turns the port blank if it is offline when the #
    #               function is called in file_rw().               #
    # Params:                                                      #
    #   - index:    value obtained from "spirent_ports" list that  #
    #               maps port string to array index.               #
    # Returns:                                                     #
    #   - None                                                     #
    ################################################################

    def set_offline(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_OUTLINED
        self.status_bubbles[index].color = colors.BLACK
        self.page.update()

    ########################## build_zone_1 ########################
    # Description:  Sets UI structure for all of ZoneOne, and      #
    #               assigns each element its corresponding function#
    # Params:                                                      #
    #   - None                                                     #
    # Returns:                                                     #
    #   - Column()                                                 #
    ################################################################

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
    

########################## ZoneTwo ###########################
# Description:  ZoneTwo holds the ListView object which      #
#               outputs status of testing to the user on the #
#               UI.                                          #
# Params:                                                    #
#   - page: reference to Flet page object                    #
# Returns:                                                   #
#   - class reference object                                 #
##############################################################

class ZoneTwo:

    def __init__(self, page) -> None:
        self.page = page
        self.lv = ListView(expand=1, spacing=10, auto_scroll=True)
        
    ######################### build_zone_2 #########################
    # Description:  Sets UI structure for all of ZoneTwo, and      #
    #               assigns each element its corresponding function#
    # Params                                                       #
    #   - None                                                     #
    # Returns                                                      #
    #   - Column()                                                 #
    ################################################################

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


########################## ZoneThree #########################
# Description:  ZoneThree holds the button object which      #
#               starts the testing process on the UI         #
# Params:                                                    #
#   - page: reference to Flet page object                    #
#   - classname: reference to ZoneOne class object           #
#   - window: reference to the ListView object in ZoneTwo    #
# Returns:                                                   #
#   - class reference object                                 #
##############################################################


class ZoneThree:

    def __init__(self, page, classname, window) -> None:
        self.page = page
        self.window = window
        self.class_name = classname
        self.window_manager = WindowManager(self.window, self.page) # Holds functions for ListView object
        self.spirent_tester = SpirentTester() # Handles functions related to testing scripts 
        self.results_manager = ResultsManager() # Handles results of testing.  
        self.start_proc() # Starts the polling threads run_tcl() and file_rw()
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

    ###################### start_proc ######################
    # Description:  Starts threads for polling status of   #
    #               Spirent ports, run_tcl() and file_rw() #
    # Params:                                              #
    #   - None                                             #
    # Returns:                                             #
    #   - None                                             #
    ########################################################
   
    def start_proc(self):
        global kill_flag
        kill_flag = False
        t1 = threading.Thread(target=run_tcl, daemon=True).start() # Creates and starts run_tcl()
        t2 = threading.Thread(target=file_rw, args=(self.class_name,), daemon=True).start() # Creates and starts file_rw()
        print("Threads started")

    ####################### btn_click ######################
    # Description:  Function to start testing when button  #
    #               is clicked.                            #
    # Params:                                              #
    #   - e: required by Flet to be a parameter to any     #
    #        function assigned to button                   #
    # Returns:                                             #
    #   - None                                             #
    ########################################################

    def btn_click(self, e):
        global kill_flag
        print("Killing status processes")
        kill_flag = True # Sets kill_flag which will cause port polling threads to stop running in file_rw()
        self.test_btn.text="TESTING"
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

        self.test_btn.text="Start Spirent Test"
        self.page.update()
        self.start_proc()

    ######################### build_zone_3 #########################
    # Description:  Sets UI structure for all of ZoneThree, and    #
    #               assigns each element its corresponding function#
    # Params                                                       #
    #   - None                                                     #
    # Returns                                                      #
    #   - Column()                                                 #
    ################################################################

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

    if args.debug:
        logging.basicConfig(stream=sys.stdout, format='%(process)d  %(levelname)s\t%(message)s', level=logging.DEBUG)
        logging.debug("_______DEBUG_______")
    else:
        # logging.basicConfig(stream=sys.stdout, format= red + '%(process)d  %(levelname)s\t%(message)s' + reset, level=logging.ERROR)
        logging.basicConfig(stream=sys.stdout, format='%(process)d  %(levelname)s\t%(message)s', level=logging.INFO)



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
