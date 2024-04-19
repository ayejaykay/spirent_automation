from subprocess import CalledProcessError
from dict import *
import global_vars
import subprocess
import logging
import os

__location__ = os.path.dirname(os.path.realpath(__file__)) # Path to current working directory where app is running from

global test_kill_flag
test_kill_flag = False

################### kill_test ####################
# Description:  Sets the test_kill_flag flag to  #
#               kill the test script if the user #
#               exits the application            #
# Params:                                        #
#   - None                                       #
# Returns:                                       #
#   - None                                       #
##################################################

def kill_test():
    global test_kill_flag
    test_kill_flag = True

##################### SpirentTester ####################
# Description:  Class holds all of the functions that  #
#               relate to testing and the Spirent tcl  #
#               scripts.                               #
# Params:                                              #
#   - None                                             #
# Returns:                                             #   
#   - Class reference object                           #
#######################################################

class SpirentTester:

    def __init__(self):
        self.filename = ""
        self.tcl_location = f'..\\Tcl\\bin\\tclsh'

    ######################## test_device ##########################
    # Description:  High level function for whole testing process.#
    #               Writes status to ListView object.             #
    # Params:                                                     #
    #   - textfield: Reference to textfield label                 #
    #     (Patch A, Patch B, Patch C and Patch D)                 #
    #   - textfield_value: Value in textfield.  Used to map value #
    #                      to proper test script file.            #
    #   - window_manager: Reference to WindowManager class init   #
    #                     in main()                               #
    # Returns:                                                    #
    #   - Modified test result. Either PASSED or error message    #
    ###############################################################

    def test_device(self, textfield, textfield_value, window_manager):

        self.textfield = textfield # Reference to textfield label (Patch A, Patch B, Patch C and Patch D)
        
        # Get spirent test file relative to textfield value
        try:
            window_manager.write_message_to_window("Getting test file")
            self.get_testing_file(textfield_value)
        except KeyError:
            # print("ERROR: Could not find test file")
            logging.error("ERROR: Could not find test file")
            window_manager.write_message_to_window("ERROR: Could not find test file")
            return

        # Write the proper ports to be used for patch
        if self.write_configuration(window_manager):
            pass
        else:
            return None

        # Start testing file from CL
        window_manager.write_message_to_window(f"STARTING TEST for {textfield_value}")
        window_manager.start_progress_bar()
        self.start_test()
        window_manager.stop_progress_bar()

        window_manager.write_message_to_window(f"Test results for {textfield_value}")
        # Read results from exported file from test
        return self.read_results() 
        # Export results and return

    ##################### write_configuration ######################
    # Description:  Based on the model unit that was scanned, this #
    #               function writes the ports that the test script #
    #               should use for testing to the config.dat file  #
    # Parmas:                                                      #
    #   - None                                                     #
    # Returns:                                                     #
    #   - None                                                     #
    ################################################################

    def write_configuration(self, wm):
        logging.debug("Writing Configuration")
        # config_data = patch[self.textfield][file_num_ports[self.filename]]
        num_ports_for_test = file_num_ports[self.filename]
        with open('online_ports.dat', 'r') as fp:
                online_ports = fp.readline()
        if num_ports_for_test != len(online_ports.split()):
                wm.write_message_to_window(f"Test requires {num_ports_for_test} ports for test. {len(online_ports.split())} ports connected")
                return False
        with open('..\\config\\config.dat', 'w') as f:
                f.write(online_ports)
                return True

    ####################### get_testing_file ##########################
    # Description:  Parses shop order number to use for dictionary.   #
    # Params:                                                         #
    #   - textfield_value: value entered into textfield (SO number)   #
    # Returns:                                                        #
    #   - None                                                        #
    ###################################################################

    def get_testing_file(self, textfield_value):
        logging.debug("Getting test file")
        dle = textfield_value.find('$')
        self.filename = product[textfield_value[7:dle]]

    ############################ start_test ############################
    # Description:  Starts the Spirent test script. Function loops to  #
    #               monitor if test is still running or not. While it  #
    #               is still running, if the test_kill_flag is set,    #
    #               then the script is terminated. It can be set from  #
    #               the shutdown() function                            #
    # Params:                                                          #
    #   - None                                                         #
    # Returns:                                                         #
    #   - None                                                         #
    ####################################################################

    def start_test(self):
        logging.debug("Starting Test")
        global test_kill_flag
        try:
            test_kill_flag = False
            sp = subprocess.Popen([self.tcl_location, f"..\\lib\\{self.filename}.tcl"])
            while(sp.poll() is None):
                if test_kill_flag:
                    # print("Killing Spirent Test Script")
                    logging.info("Killing Spirent Test Script")
                    sp.terminate()
                    sp.wait()
                    break

        except CalledProcessError:
            pass

    ########################### read_results ##########################
    # Description:  The results of the test script are exported to a  #
    #               log file. This function searches through the file #
    #               for any error messages.  If none are found, then  #
    #               we know that the test passed.                     #
    # Params:                                                         #
    #   - None                                                        #
    # Returns:                                                        #
    #   - Results of test as string                                   #
    ###################################################################

    def read_results(self):
        logging.debug("Reading Result")
        counter=0
        errors_arr = []
        with open(f'..\\lib\\{self.filename}_log.txt', 'r') as f:
            log = f.readlines()
            for line in log:
                if 'ERROR -' in line:
                    errormsg = ""
                    errline = ""
                    while 'INFO' not in errline:
                        errline = log[counter]
                        errormsg+=errline
                        counter+=1
                    errors_arr.append(errormsg)
                    counter-=1
                    #return errormsg 
                counter+=1

            if errors_arr == []:
                return ["ALL TESTS PASSED"]
            else:
                print(errors_arr)
                return errors_arr

    
