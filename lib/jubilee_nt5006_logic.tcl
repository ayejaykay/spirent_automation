# Spirent TestCenter Logic Script
# Generated on Wed Dec 06 12:30:57 2023 by NTtest
# Framework ver. 4.70.9706.0000
#
# Comments: 
# 
#
# This logic script contains the following routines invoked from the
# jubilee_nt5006.tcl script.

# Load Spirent TestCenter
package require SpirentTestCenter
#source SpirentTestCenter.tcl

#    init - set the logging level and logging location (stdout).
#           Possible logLevel values are: 
#             DEBUG - Display DEBUG, INFO, WARN, and ERROR messages
#             INFO  - Display INFO, WARN, and ERROR messages
#             WARN  - Display WARN and ERROR messages
#             ERROR - Display only ERROR messages
#
#           Possible values for logTo are "stdout" or a file name (can include
#           the path). Use forward slashes between directory names.
proc init { location } {
    stc::config automationoptions -logTo $location -logLevel INFO
}

#    configResultLocation -  set the location for results files.
#            Possible values are: 
#              INSTALL_DIR - Spirent TestCenter installation directory.
#              CURRENT_WORKING_DIR - Current working directory. This 
#                  is the directory that Spirent TestCenter currently
#                  has open.
#              USER_WORKING_DIR - User working directory.
#              CURRENT_CONFIG_DIR - Current configuration directory. 
#                  This is the directory where the saved or loaded
#                  .xml or .tcc file is located. If no .xml or .tcc 
#                  file has been saved or loaded, files are saved
#                  to the user working directory.
#
#            The location of the results files can be modified in the
#            launcher file. The saveResultsRelativeTo parameter sets a path 
#            that is prepended to the value of the ResultsDirectory 
#            parameter. To set an fully qualified (absolute) path for 
#            results, set the ResultsDirectory parameter and set 
#            SaveResultsRelativeTo to NONE.
proc configResultLocation  { location } {
    set TestResultSetting(1) [lindex [stc::get System1.Project -children-TestResultSetting] 0]
    puts $location
    stc::config $TestResultSetting(1) -saveResultsRelativeTo NONE -resultsDirectory $location
}

#    configMiscOptions - set up the sequencer. Currently sets the sequencer
#                        to stop on any error.  Other options are IGNORE_ERROR and 
#                        PAUSE_ON_ERROR.
proc configMiscOptions  {} {
    set Sequencer(1) [lindex [stc::get system1 -children-sequencer] 0]
    stc::config $Sequencer(1) -ErrorHandler STOP_ON_ERROR
}

#    config - load the configuration into memory. The port locations
#             are taken from the XML file but may be passed in from the
#             launcher script.
proc config {portLocations} {

    set StcSystem(1) [ stc::perform loadfromxml -filename [ file normalize [ file join [ file dirname [ info script ] ] {jubilee_nt5006.xml} ] ] ]

    if {[llength $portLocations] > 0} {
        array set cmdResult [ stc::perform GetObjects -ClassName Port -Condition IsVirtual=false ]
        set ports $cmdResult(-ObjectList)
        set idx 0
        foreach port $ports {
            stc::config $port -location [ lindex $portLocations $idx ]
            incr idx
        }
    }

    # Save to an XML file, if desired
    #stc::perform saveAsXml -config system1 -filename sampleSavedFilename.xml
    
    # Save to a Tcl file, if desired
    #stc::perform saveAsTcl -config system1 -filename sampleSavedFilename.tcl

}

#    connect - perform the logical to physical port mapping, connect to the 
#              chassis' and reserve the ports. This routine performs the connect,
#              reserve, and logical to physical port mappings directly.
#              The port list is retrieved from the in-memory configuration.
proc connect {} {
    stc::perform attachPorts -autoConnect true -portList [ stc::get project1 -children-Port ]
}

#    apply - apply writes the logical information held in memory on the 
#            workstation to the ports in the STC chassis'.
proc apply {} {
    stc::apply
}

#    run - subscribe to any results views located in the in-memory configuration
#          and execute the sequencer and return the test status from the 
#          command sequence, if any. Test status is set by the Stopped Reason
#          in the Stop Command Sequence command. This is a string value and 
#          can be anything. If there is no sequence defined or no Stop 
#          Command Sequence command is executed, then the test state is 
#          returned. Test state can take the values: NONE, PASSED or FAILED.
proc run {} {
    # Subscribe to results for result query jubilee_nt5006-0001-rxstreamsummaryresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType streamblock \
        -resultType rxstreamsummaryresults \
        -filterList "[lindex [stc::get system1.Project(1) -children-RxPortResultFilter] 1] " \
        -viewAttributeList "framecount sigframecount fcserrorframecount minlatency maxlatency droppedframecount droppedframepercent inorderframecount reorderedframecount duplicateframecount lateframecount prbsbiterrorcount prbsfilloctetcount ipv4checksumerrorcount tcpudpchecksumerrorcount framerate sigframerate fcserrorframerate droppedframerate droppedframepercentrate inorderframerate reorderedframerate duplicateframerate lateframerate prbsbiterrorrate prbsfilloctetrate ipv4checksumerrorrate tcpudpchecksumerrorrate bitrate shorttermavglatency avglatency prbsbiterrorratio l1bitcount l1bitrate prbserrorframecount prbserrorframerate portstrayframes bitcount shorttermavgjitter avgjitter rfc4689absoluteavgjitter minjitter maxjitter shorttermavginterarrivaltime avginterarrivaltime mininterarrivaltime maxinterarrivaltime inseqframecount outseqframecount inseqframerate outseqframerate histbin1count histbin2count histbin3count histbin4count histbin5count histbin6count histbin7count histbin8count histbin9count histbin10count histbin11count histbin12count histbin13count histbin14count histbin15count histbin16count aggregatedrxportcount " \
        -interval 1 -filenamePrefix "jubilee_nt5006-0001-rxstreamsummaryresults"

    # Subscribe to results for result query jubilee_nt5006-0002-txstreamresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType streamblock \
        -resultType txstreamresults \
        -filterList "" \
        -viewAttributeList "framecount framerate bitrate expectedrxframecount l1bitcount l1bitrate bitcount streaminfo " \
        -interval 1 -filenamePrefix "jubilee_nt5006-0002-txstreamresults"

    # Start the sequencer
    stc::perform sequencerStart

    # Wait for sequencer to finish
    stc::waituntilcomplete

    # check the sequencer status and test state
    set sqrHandle [stc::get System1 -Children-Sequencer]
    set sqrStatus [stc::get $sqrHandle -Status]
    set sqrTestState [stc::get $sqrHandle -TestState]
    if { $sqrStatus eq "" }  {
	puts $sqrTestState
        return $sqrTestState
    } else {
        return $sqrStatus
    }

}

#    cleanup - release the ports, disconnect from the chassis' and reset 
#              the in-memory configuration.
proc cleanup {} {
    stc::perform chassisDisconnectAll 
    stc::perform resetConfig
}