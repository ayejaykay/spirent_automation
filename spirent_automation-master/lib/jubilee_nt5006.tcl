# Spirent TestCenter Launcher Script
# Generated on Wed Dec 06 12:30:57 2023 by NTtest
# Framework ver. 4.70.9706.0000
#
# Comments: 
# 
#
# This launcher script invokes the following routines contained in the
# jubilee_nt5006_logic.tcl script. After sourcing the logic script,
# the logic flow is as follows:
#
# init - set the logging level and logging location (stdout).
#
# config - load the configuration into memory and set the STC port locations.
#          The port locations can be modified in this file.
#
# configResultLocation -  set the location for results files.
#                         The location of the results files can be modified in this file.
#                         This does not set the location of the log files. Set 
#                         the STC_LOG_OUTPUT_DIRECTORY environment variable to choose 
#                         a log file location.
#
# configMiscOptions - set up the sequencer.
#
# connect - perform the logical to physical port mapping, connect to the 
#           chassis' and reserve the ports.
#
# apply - write the configuration to the ports.
#
# run - execute the sequencer and obtain the test status from the 
#       Basic: Stop Command Sequence "Stopped Reason" value. If there
#       is no sequence defined, then the test state is returned: NONE,
#       PASSED or FAILED.
#
# cleanup - disconnect from the chassis (releases the ports) and reset 
#           the in memory configuration.
#
# return - return the test status obtained from the sequencer execution
#          to the caller.

proc listFromFile {filename} {
	set f [open $filename r]
	set data [split [string trim [read $f]]]
	close $f
	return $data
}


source [ file normalize [ file join [ file dirname [ info script ] ] {jubilee_nt5006_logic.tcl} ] ]


init [ file normalize [file join [ file dirname [ info script ] ] {jubilee_nt5006_log.txt} ] ]
 #config [list "//10.11.1.3/1/1" "//10.11.1.3/1/2" "//10.11.1.3/1/3" "//10.11.1.3/1/4" "//10.11.1.3/1/5" "//10.11.1.3/1/6" ]
config [listFromFile ..\\config\\config.dat]
configResultLocation [ file normalize [ file dirname [ info script ] ] ]
configMiscOptions
connect
apply
set test_status [eval [concat run ]]
cleanup
puts "Test Status"; puts $test_status
return $test_status
