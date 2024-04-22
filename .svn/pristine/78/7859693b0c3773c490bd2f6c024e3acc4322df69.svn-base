from dict import *
import subprocess
import multiprocessing
import time
import queue

q = multiprocessing.Queue()


def create_proc_1():
    return multiprocessing.Process(target=run_tcl)

def create_proc_2(zone):
    return multiprocessing.Process(target=file_rw)

def run_tcl():
    tcl_location = "..\\Tcl\\bin\\tclsh"
    kill_flag = False
    not_running = True
    data = ""
    while(not kill_flag):
        try:
            if not_running:
                print("Starting Test Script")
                sp = subprocess.Popen([tcl_location, "verify_link.tcl"])
                not_running = False
            elif data == "KILL":
                print("Killing Subprocess")
                sp.terminate()
                sp.wait()
                kill_flag = True

            data = q.get(block=False)
        except queue.Empty:
            pass


def file_rw():
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
            time.sleep(8)
        except FileNotFoundError:
            print("Waiting on file write")
            time.sleep(3)

