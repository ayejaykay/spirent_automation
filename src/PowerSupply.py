import pyvisa
import time

# I think that if there is not NI-VISA on the computer we are using for testing
# then we are going to have to install it at NI Website --> https://www.ni.com/en/support/downloads/drivers/download/packaged.ni-visa.494653.html

class PowerSupply:

    def __init__(self):
        self.rm = pyvisa.ResourceManager() # We can specify this with the path to the NI-VISA library
        
        if self.rm == None:
            print("ERROR: NO PATH TO VISA LIBRARY")
            return
        
        print(f"Path to VISA Library: {self.rm}")

        self.power_supply_id = 'USB0::0xFFFF::0x9130::802359043757410053::INSTR'

        self.instrument = self.rm.open_resource(self.power_supply_id)

        self.instrument.read_termination = '\n'
        self.instrument.write_termination = '\n'

        print(f'Instrument Information: {self.instrument.query('*IDN?')}')
        self.init_power_supply()

    def init_power_supply(self):
        print('Resetting Instrument...')
        self.instrument.write('*ESE 60;*SRE 48;*CLS')
        print(self.instrument.write('*RST'))
        print('Instrument Reset')

    def on_power_supply(self, channel, value):
        print("Turning on power supply...")
        self.instrument.write(f"INST CH{channel}")
        self.instrument.write(f"VOLT {value}V")
        self.instrument.write("CHAN:OUTP 1")
        return self.instrument.query("OUTP:STAT?")

    def off_power_supply(self, channel):
        print("Turning off power supply...")
        self.instrument.write(f"INST CH{channel}")
        self.instrument.write(f"VOLT 0V")
        self.instrument.write("CHAN:OUTP 0")
        return self.instrument.query("OUTP:STAT?")

