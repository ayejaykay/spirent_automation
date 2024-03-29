from SpirentTester import *
import subprocess
import time
import os

__location__ = os.path.dirname(os.path.realpath(__file__)) # Path to current working directory where app is running from

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

