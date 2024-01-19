from dict import *
import subprocess
from subprocess import CalledProcessError
import os

__location__ = os.path.dirname(os.path.realpath(__file__))

def print_progress(iteration, total):
        percent = ("{0:.1f}").format(100 * (iteration / float(total)))
        filled_length = int(iteration//total)
        fill = '\u2588'
        bar = fill * filled_length + '-' * (100 - filled_length)
        print(f'\rProgress: | {bar} | {percent}% Complete', end = '\r')
        if iteration == total:
            print()

class SpirentTester:

    def __init__(self):
        # self.textfield_value = textfield_value
        self.filename = ""
        self.tcl_location = f'..\\Tcl\\bin\\tclsh'

        print(self.tcl_location)
     

    def test_device(self, textfield, textfield_value, window_manager):

        self.textfield = textfield # Reference to textfield label (Patch A, Patch B, Patch C and Patch D)
        
        # Get spirent test file relative to textfield value
        try:
            window_manager.write_message_to_window("Getting test file")
            self.get_testing_file(textfield_value)
        except KeyError:
            print("ERROR: Could not find test file")
            window_manager.write_message_to_window("ERROR: Could not find test file")
            return

        # Write the proper ports to be used for patch
        self.write_configuration()

        # Start testing file from CL
        window_manager.write_message_to_window(f"STARTING TEST for {textfield_value}")
        window_manager.start_progress_bar()
        self.start_test()
        window_manager.stop_progress_bar()

        window_manager.write_message_to_window(f"Test results for {textfield_value}")
        # Read results from exported file from test
        return self.read_results() 
        # Export results and return

    def write_configuration(self):
        config_data = patch[self.textfield][file_num_ports[self.filename]]
        with open('..\\config\\config.dat', 'w') as f:
            f.write(config_data)
        print(config_data)

    def get_testing_file(self, textfield_value):
        dle = textfield_value.find('$')
        self.filename = product[textfield_value[7:dle]]

    def start_test(self):
        try:
            cmd = f'{self.tcl_location} ..\\lib\\{self.filename}.tcl'
            subprocess.run(cmd, shell=True, check=True)
        except CalledProcessError:
            pass


    def read_results(self):
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

    
