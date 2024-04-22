from ResultsManager import *
from WindowManager import *
from SpirentTester import *
from RedlionSQL import *
from Globals import *
import threading
import time
import os

try:
    from flet import *
except ImportError:
    os.system("pip install flet")

__location__ = os.path.dirname(os.path.realpath(__file__))

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

    def __init__(self, page, classname, window, patch_letter) -> None:
        print("init zone 3")
        self.page = page
        self.patch_letter = patch_letter
        self.window = window
        self.class_name = classname
        self.window_manager = WindowManager(self.window, self.page) # Holds functions for ListView object
        self.spirent_tester = SpirentTester() # Handles functions related to testing scripts 
        self.results_manager = ResultsManager() # Handles results of testing.  
        self.sql_ref = RedlionSQL('Test_Engineering_NTRON', 'SpirentTester')
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
        global_vars.kill_flag = False
        t1 = threading.Thread(target=run_tcl, daemon=True).start() # Creates and starts run_tcl()
        t2 = threading.Thread(target=file_rw, args=(self.class_name,self.patch_letter, self.window_manager), daemon=True).start() # Creates and starts file_rw()
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


        # var_arr = [self.class_name.text_a]
        tb_ref = self.class_name.text_a
        shop_order = self.class_name.text_a.value
        serial_num = self.class_name.text_b.value

        if shop_order == "":
            self.window_manager.write_message_to_window("No shop order entered. Stopping test")
            return 
        
        if serial_num == "":
            self.window_manager.write_message_to_window("No serial number entered. Stopping test")
            return 

        # SHOULD ADD DEV MODE FOR SERVER.  THAT WAY WE ARE NOT QUERYING ACTUAL SERVER WHEN DOING DEV STUFF

        if not self.uut_testable(serial_num):
            self.window_manager.write_message_to_window("Unable to perform Spirent Test because UUT has not been programmed or final tested")
            self.window_manager.write_message_to_window("Please perform previous tests before Spirent Testing")
            return 

        print("Killing status processes")
        global_vars.kill_flag = True # Sets kill_flag which will cause port polling threads to stop running in file_rw()
        print("global kill_flag set")
        self.test_btn.text="TESTING"
        time.sleep(3)

        self.page.update()

        arr = []
        try:
            arr = self.spirent_tester.test_device(tb_ref.label, shop_order, self.window_manager, serial_num)
            if  not arr == None:
                for j in arr:
                    self.window_manager.write_message_to_window(j)
            self.results_manager.transmit_data(arr, tb_ref.label, shop_order, serial_num, self.sql_ref)
            arr = []
        except TypeError:
            pass


        try:
            os.remove(f"{__location__}\\linkstatus.dat")
        except FileNotFoundError:
            pass

        self.test_btn.text="Start Spirent Test"
        self.page.update()
        self.start_proc()

    ################ uut_testable ###############
    # Description: Checks if serial number has  #
    #              been programmed and final    #
    #              tested.                      #
    # Params:                                   #
    #   - serial_num: Serial number of unit to  #
    #     query database for. (String)          #
    # Returns:                                  #
    #   - Boolean                               #
    #############################################

    def uut_testable(self, serial_num):
        return (self.sql_ref.serial_is_final_tested(serial_num) and self.sql_ref.serial_is_programed(serial_num))

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

