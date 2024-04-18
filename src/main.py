from ResultsManager import *
from SpirentTester import *
from WindowManager import *
from PowerSupply import *
from ZoneThree import *
from ZoneOne import *
from ZoneTwo import *
from dict import *
import global_vars
import subprocess
import threading
import argparse
import logging
import atexit
import queue
import time
import sys
import os

# Try to import flet library.  If not installed on PC then program installs
try:
    from flet import *
except ImportError:
    os.system("pip install flet")

__location__ = os.path.dirname(os.path.realpath(__file__)) # Path to current working directory where app is running from

global_vars.init()

# Argument definition to run in debug mode.  It is optional argument
parser = argparse.ArgumentParser("Spirent Automation Debug")

parser.add_argument('-d', '--debug', action='store_true')

args = parser.parse_args()

# Colors for printing to console
yellow = "\x1b[33;20m"
red = "\x1b[31;20m"
reset = "\x1b[0m"

global_vars.kill_flag = False # Kills TCC polling function that checks which ports are online
global_vars.restart_flag = False # Restarts the polling script once we reach the subscription error from spirent.  max is 32 

global_vars.ps = PowerSupply() # Inititalizes the power supply when the application starts
global_vars.ps.on_power_supply(1, 24) # Turns on the power supply to 24VDC right after initialization

# Main Function
def main(page: Page):
    page.title = "Spirent Automation"

    if args.debug:
        logging.basicConfig(stream=sys.stdout, format='%(process)d  %(levelname)s\t%(message)s', level=logging.DEBUG)
        logging.debug("_______DEBUG_______")
    else:
        # logging.basicConfig(stream=sys.stdout, format= red + '%(process)d  %(levelname)s\t%(message)s' + reset, level=logging.ERROR)
        logging.basicConfig(stream=sys.stdout, format='%(process)d  %(levelname)s\t%(message)s', level=logging.INFO)

    spirent_ip = configure_spirent()
    patch_id = patch_letter[spirent_ip]
    write_config_file(patch_id)

    z1 = ZoneOne(page, patch_id)
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
