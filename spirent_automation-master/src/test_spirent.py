import os
import atexit
import time
import multiprocessing
import subprocess
from LinkStatus import *
from dict import *
import os
import signal

tcl_location = f'..\\Tcl\\bin\\tclsh'


class SubProc:

    def __init__(self):
        self.tcl_location = f'..\\Tcl\\bin\\tclsh'
        self.cmd = f'{self.tcl_location} ..\\lib\\verify_link.tcl'
        self._pid = 0
        self._gpid = 0

    def start_subproc(self):
        ref = subprocess.Popen([self.tcl_location, '..\\lib\\verify_link.tcl'])
        self._pid = ref.pid
        print(self._pid)
        self._gpid = os.getpgid(ref.pid)
        print(self._gpid)

    def end_subproc(self):
        os.kill(self._pid, signal.SIGTERM)
    
def run_tcl(ref):
    ref.start_subproc()

def file_rw():
    # Open file, read status, set flags, etc.
    time.sleep(10)
    while(1):
        try:
            port_arr = []
            with open('linkstatus.dat','r') as fp:
                fp.readline()
                data = fp.readlines()
                counter = 0
                for line in data:
                    counter+=1
                    if "//" in line:
                        port_arr.append((line[6:-1]))
            for i in spirent_ports:
                if i in port_arr:
                    print(f"{i} offline")
                else:
                    print(f"{i} online")
            time.sleep(8)
        except FileNotFoundError:
            print('Waiting on file write')
            time.sleep(3)
            pass


def clear_file():
    open('linkstatus.dat', 'w').close()

def del_file():
    clear_file()
    os.remove('linkstatus.dat')

def handle_exit():
    del_file()

def main():
    sp = SubProc()
    p1 = multiprocessing.Process(target=run_tcl, args=(sp,))
    p2 = multiprocessing.Process(target=file_rw)

    p1.start()
    p2.start()
    print("Processes started")


    time.sleep(30)
    
    sp.end_subproc()
    p1.terminate()
    p1.join()
    p2.terminate()
    p2.join()
    print("Processes Terminated")

    time.sleep(30)

    p1 = multiprocessing.Process(target=run_tcl)
    p2 = multiprocessing.Process(target=file_rw)

    p1.start()
    p2.start()
    print("Processes Started")

    time.sleep(30)

    p1.terminate()
    p1.join()
    p2.terminate()
    p2.join()
    print("Processes Terminated")




if __name__ == "__main__":
    main()
