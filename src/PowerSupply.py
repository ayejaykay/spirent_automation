# import pyvisa 
import logging
import time
import os

try:
    import pyvisa
except ImportError:
    os.system("pip install pyvisa") 

__location__ = os.path.dirname(os.path.realpath(__file__))

# I think that if there is not NI-VISA on the computer we are using for testing
# then we are going to have to install it at NI Website --> https://www.ni.com/en/support/downloads/drivers/download/packaged.ni-visa.494653.html

# This code also assumes that we are using the 913xB power supply from BK Precision. If it is something different, there could be a VID/PID pair
# that is different than what is hardcoded here.  As of right now, we can dynamically find the VID, but have a hardcoded PID. 

####################### PowerSupply #####################
# Description:  This class controls the DC power supply #
#               that powers the UUT. We are using the   #
#               pyvisa library to send SCPI commands    #
# Params:                                               #
#   - None                                              #
# Returns:                                              #
#   - Class reference object                            #
#########################################################

class PowerSupply:

    def __init__(self):
        self.ps_finder_file = "findps.txt"
        self.rm = pyvisa.ResourceManager() # We can specify this with the path to the NI-VISA library
        self.ps_id = self.find_power_supply_ref()
        
        if self.rm == None:
            # print("ERROR: NO PATH TO VISA LIBRARY")
            logging.error("NO PATH TO VISA LIBRARY")
            return
        
        print(f"Path to VISA Library: {self.rm}")
        logging.debug(f"Path to VISA Library: {self.rm}")

        self.power_supply_id = f'USB0::0x{self.ps_id[0]}::0x9130::{self.ps_id[1]}::INSTR'

        print(self.power_supply_id)

        self.instrument = self.rm.open_resource(self.power_supply_id)

        self.instrument.read_termination = '\n'
        self.instrument.write_termination = '\n'

        # print(f'Instrument Information: {self.instrument.query('*IDN?')}')
        logging.info(f'Instrument Information: {self.instrument.query("*IDN?")}')

        self.init_power_supply()

    ################ find_power_supply ################
    # Description:  Finds the instance id of the DC   #
    #               power supply and extracts the VID #
    #               and the hardware ID from response #
    #               We are also checking that there   #
    #               only one available DC power supply#
    # Params:                                         #
    #   - None                                        #
    # Returns:                                        #
    #   - Tuple (VID, Hardware ID)                    #
    ###################################################

    def find_power_supply_ref(self):
        os.system(f"pnputil /enum-devices /connected | findstr PID_9130 > \"{self.ps_finder_file}\"")
        with open(f"{self.ps_finder_file}", "r") as fp:
            data = fp.readlines()
            if(len(data)>1):
                logging.error("MORE THAN ONE DC POWER SUPPLY AVAILABLE. I can't decide which to use yet ):")
                return
            else:
                vid_index = str(data).find("VID_")+len("VID_")
                andpersand = str(data).find("&")
                vid_add = str(data)[vid_index:andpersand]
                instance_id_index_start = str(data).find("PID_9130\\") + len("PID_9130\\") + 1
                newline_index = str(data).find("\\n")
        os.remove(self.ps_finder_file)
        return (vid_add, str(data)[instance_id_index_start:newline_index])

    ################ init_power_supply ################
    # Description:  Initializes the power supply to   #
    #               turn on.                          #
    # Params:                                         #
    #   - None                                        #
    # Returns:                                        #
    #   - None                                        #
    ###################################################

    def init_power_supply(self):
        # print('Resetting Instrument...')
        logging.info('Resetting Instrument...')
        self.instrument.write("*ESE 60;*SRE 48;*CLS")
        # print(self.instrument.write('*RST'))
        logging.info(self.instrument.write("*RST"))
        # print('Instrument Reset')
        logging.info('Instrument Reset')

    ################ on_power_supply ##################
    # Description:  Turns on the power supply channel #
    #               to code defined voltage.          #
    # Params:                                         #
    #   - channel: channel to set voltage on          #
    #   - value: voltage value to set power supply to #
    # Returns:                                        #
    #   - Ouput status of the power supply            #
    ###################################################

    def on_power_supply(self, channel, value):
        # print("Turning on power supply...")
        logging.info("Turning on power supply...")
        self.instrument.write(f"INST CH{channel}")
        self.instrument.write(f"VOLT {value}V")
        self.instrument.write("CHAN:OUTP 1")
        return self.instrument.query("OUTP:STAT?")

    ################ off_power_supply #################
    # Description:  Turns off power supply channel    #
    # Params:                                         #
    #   - channel: channel to turn off                #
    # Returns:                                        #
    #   - Output status of the power supply           #
    ###################################################

    def off_power_supply(self, channel):
        # print("Turning off power supply...")
        logging.info("Turning off power supply...")
        self.instrument.write(f"INST CH{channel}")
        self.instrument.write(f"VOLT 0V")
        self.instrument.write("CHAN:OUTP 0")
        return self.instrument.query("OUTP:STAT?")

