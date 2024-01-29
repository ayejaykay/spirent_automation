# Spirent TestCenter Logic Script
# Generated on Wed Jan 17 13:43:25 2024 by NTtest
# Framework ver. 4.70.9706.0000
#
# Comments: 
# 
#
# This logic script contains the following routines invoked from the
# ping.tcl script.

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
proc init {} {
    stc::config automationoptions -logTo stdout -logLevel WARN
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
    stc::config $TestResultSetting(1) -saveResultsRelativeTo NONE -resultsDirectory $location
}

#    configMiscOptions - set up the sequencer. Currently sets the sequencer
#                        to stop on any error.  Other options are IGNORE_ERROR and 
#                        PAUSE_ON_ERROR.
proc configMiscOptions  {} {
    set Sequencer(1) [lindex [stc::get system1 -children-sequencer] 0]
    stc::config $Sequencer(1) -ErrorHandler STOP_ON_ERROR
}

#    config - load the configuration into memory and set the STC port locations.
#             The port locations can be modified in the launcher file. This 
#             routine contains the majority of the object creation and attribute
#             setting code taken from the GUI configuration. Near the end of 
#             this routine is a set of lines that specifies the protocol stack 
#             linkages for both the stream blocks and any configured protocols. 
#             Following that code is the command sequence construction code.
proc config {portLocations} {
stc::config system1 -IsLoadingFromConfiguration "true"

set system1 system1
stc::config system1 \
        -UseSmbMessaging "FALSE" \
        -ApplicationName {TestCenter}

set Project(1) [stc::create "Project" \
        -TableViewData "" \
        -SelectedTechnologyProfiles {} \
        -ConfigurationFileName {ping.tcl} ]

set Port(1) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 0] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/1} ]

set Port(2) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 1] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/2} ]

set Port(3) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 2] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/3} ]

set Port(4) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 3] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/4} ]

set Port(5) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 4] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/5} ]

set Port(6) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 5] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/6} ]

set Port(7) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 6] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/7} ]

set Port(8) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 7] \
        -PortGroupSize "1" \
        -TestModuleProfile {Default} \
        -Name {Port //1/8} ]

set FrameLengthDistribution(1) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {Default} ]

set FrameLengthDistributionSlot(1) [lindex [stc::get $FrameLengthDistribution(1) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(1) \
        -FixedFrameLength "40" \
        -MinFrameLength "40" \
        -MaxFrameLength "41" \
        -Weight "7"

set FrameLengthDistributionSlot(2) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(1) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" \
        -Weight "4" ]

set FrameLengthDistributionSlot(3) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(1) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" ]

set FrameLengthDistribution(2) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {Spirent} ]

set FrameLengthDistributionSlot(4) [lindex [stc::get $FrameLengthDistribution(2) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(4) \
        -FixedFrameLength "40" \
        -MinFrameLength "40" \
        -MaxFrameLength "41" \
        -Weight "5867"

set FrameLengthDistributionSlot(5) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(2) \
        -FixedFrameLength "44" \
        -MinFrameLength "43" \
        -MaxFrameLength "45" \
        -Weight "200" ]

set FrameLengthDistributionSlot(6) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(2) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" \
        -Weight "2366" ]

set FrameLengthDistributionSlot(7) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(2) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" \
        -Weight "1567" ]

set FrameLengthDistribution(3) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {4-Point} ]

set FrameLengthDistributionSlot(8) [lindex [stc::get $FrameLengthDistribution(3) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(8) \
        -FixedFrameLength "40" \
        -MinFrameLength "40" \
        -MaxFrameLength "41" \
        -Weight "55"

set FrameLengthDistributionSlot(9) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(3) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" \
        -Weight "15" ]

set FrameLengthDistributionSlot(10) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(3) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" \
        -Weight "10" ]

set FrameLengthDistributionSlot(11) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(3) \
        -FrameLengthMode "RANDOM" \
        -FixedFrameLength "730" \
        -MinFrameLength "40" \
        -MaxFrameLength "1500" \
        -Weight "20" ]

set FrameLengthDistribution(4) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {TCPv4} ]

set FrameLengthDistributionSlot(12) [lindex [stc::get $FrameLengthDistribution(4) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(12) \
        -FixedFrameLength "72" \
        -MinFrameLength "71" \
        -MaxFrameLength "73" \
        -Weight "5867"

set FrameLengthDistributionSlot(13) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(4) \
        -FixedFrameLength "74" \
        -MinFrameLength "73" \
        -MaxFrameLength "75" \
        -Weight "200" ]

set FrameLengthDistributionSlot(14) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(4) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" \
        -Weight "2366" ]

set FrameLengthDistributionSlot(15) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(4) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" \
        -Weight "1567" ]

set FrameLengthDistribution(5) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {IPSEC} ]

set FrameLengthDistributionSlot(16) [lindex [stc::get $FrameLengthDistribution(5) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(16) \
        -FixedFrameLength "72" \
        -MinFrameLength "71" \
        -MaxFrameLength "73" \
        -Weight "5867"

set FrameLengthDistributionSlot(17) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(5) \
        -FixedFrameLength "74" \
        -MinFrameLength "73" \
        -MaxFrameLength "75" \
        -Weight "200" ]

set FrameLengthDistributionSlot(18) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(5) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" \
        -Weight "2366" ]

set FrameLengthDistributionSlot(19) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(5) \
        -FixedFrameLength "1400" \
        -MinFrameLength "1399" \
        -MaxFrameLength "1401" \
        -Weight "1567" ]

set FrameLengthDistribution(6) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {JMIX Downstream} ]

set FrameLengthDistributionSlot(20) [lindex [stc::get $FrameLengthDistribution(6) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(20) \
        -FixedFrameLength "60" \
        -MinFrameLength "59" \
        -MaxFrameLength "61" \
        -Weight "3"

set FrameLengthDistributionSlot(21) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(6) \
        -FixedFrameLength "120" \
        -MinFrameLength "119" \
        -MaxFrameLength "121" \
        -Weight "4" ]

set FrameLengthDistributionSlot(22) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(6) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" ]

set FrameLengthDistributionSlot(23) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(6) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" \
        -Weight "5" ]

set FrameLengthDistribution(7) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {JMIX Upstream} ]

set FrameLengthDistributionSlot(24) [lindex [stc::get $FrameLengthDistribution(7) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(24) \
        -FixedFrameLength "60" \
        -MinFrameLength "59" \
        -MaxFrameLength "61" \
        -Weight "7"

set FrameLengthDistributionSlot(25) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(7) \
        -FixedFrameLength "120" \
        -MinFrameLength "119" \
        -MaxFrameLength "121" \
        -Weight "8" ]

set FrameLengthDistributionSlot(26) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(7) \
        -FixedFrameLength "576" \
        -MinFrameLength "575" \
        -MaxFrameLength "577" ]

set FrameLengthDistributionSlot(27) [stc::create "FrameLengthDistributionSlot" \
        -under $FrameLengthDistribution(7) \
        -FixedFrameLength "1500" \
        -MinFrameLength "1499" \
        -MaxFrameLength "1500" \
        -Weight "3" ]

set Tags(1) [lindex [stc::get $Project(1) -children-Tags] 0]


set Tag(1) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Host} ]

set Tag(2) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Router} ]

set Tag(3) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Client} ]

set Tag(4) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Server} ]

set Tag(5) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Core} ]

set Tag(6) [stc::create "Tag" \
        -under $Tags(1) \
        -Name {Edge} ]

set DeviceAddrOptions(1) [lindex [stc::get $Project(1) -children-DeviceAddrOptions] 0]
stc::config $DeviceAddrOptions(1) \
        -Ipv4Increment "0.0.0.1" \
        -NextIpv6 "2001::2" \
        -Ipv6Increment "::1" \
        -NextMac "00:10:94:00:00:01" \
        -RouterIdIncrement "0.0.0.1" \
        -UseForDeviceGenConfigExpand "TRUE"

set Ieee80211PhyOptions(1) [lindex [stc::get $Project(1) -children-Ieee80211PhyOptions] 0]


set PhyOptions(1) [lindex [stc::get $Project(1) -children-PhyOptions] 0]


set TestResultSetting(1) [lindex [stc::get $Project(1) -children-TestResultSetting] 0]


set PortOptions(1) [lindex [stc::get $Project(1) -children-PortOptions] 0]


set RealismOptions(1) [lindex [stc::get $Project(1) -children-RealismOptions] 0]


set TrafficOptions(1) [lindex [stc::get $Project(1) -children-TrafficOptions] 0]


set GroupHistogram(1) [lindex [stc::get $Project(1) -children-GroupHistogram] 0]


set ResultOptions(1) [lindex [stc::get $Project(1) -children-ResultOptions] 0]
stc::config $ResultOptions(1) \
        -TimedRefreshResultViewMode "PERIODIC" \
        -TimedRefreshInterval "1" \
        -SaveAtEotProperties {}

set LabelBindingGlobalConfig(1) [lindex [stc::get $Project(1) -children-LabelBindingGlobalConfig] 0]


set MplsTpGlobalConfig(1) [lindex [stc::get $Project(1) -children-MplsTpGlobalConfig] 0]


set BgpGlobalConfig(1) [lindex [stc::get $Project(1) -children-BgpGlobalConfig] 0]


set BgpSrGlobalConfig(1) [lindex [stc::get $BgpGlobalConfig(1) -children-BgpSrGlobalConfig] 0]


set BgpSrGlobalBlock(1) [lindex [stc::get $BgpSrGlobalConfig(1) -children-BgpSrGlobalBlock] 0]


set PimGlobalConfig(1) [lindex [stc::get $Project(1) -children-PimGlobalConfig] 0]


set IsisGlobalConfig(1) [lindex [stc::get $Project(1) -children-IsisGlobalConfig] 0]


set IsisPlsbGlobalConfig(1) [lindex [stc::get $Project(1) -children-IsisPlsbGlobalConfig] 0]


set L2LearningConfig(1) [lindex [stc::get $Project(1) -children-L2LearningConfig] 0]


set ArpNdConfig(1) [lindex [stc::get $Project(1) -children-ArpNdConfig] 0]


set OtvOptions(1) [lindex [stc::get $Project(1) -children-OtvOptions] 0]


set VxlanGlobalConfig(1) [lindex [stc::get $Project(1) -children-VxlanGlobalConfig] 0]


set Dhcpv4Options(1) [lindex [stc::get $Project(1) -children-Dhcpv4Options] 0]


set Dhcpv6Options(1) [lindex [stc::get $Project(1) -children-Dhcpv6Options] 0]


set PppoxOptions(1) [lindex [stc::get $Project(1) -children-PppoxOptions] 0]


set MplsTpOamGlobalConfig(1) [lindex [stc::get $Project(1) -children-MplsTpOamGlobalConfig] 0]


set EoamGlobalConfig(1) [lindex [stc::get $Project(1) -children-EoamGlobalConfig] 0]


set VqAnalyzerOptions(1) [lindex [stc::get $Project(1) -children-VqAnalyzerOptions] 0]


set ExternalDeviceOption(1) [lindex [stc::get $Project(1) -children-ExternalDeviceOption] 0]


set Dot1xOptions(1) [lindex [stc::get $Project(1) -children-Dot1xOptions] 0]


set VicGlobalConfig(1) [lindex [stc::get $Project(1) -children-VicGlobalConfig] 0]


set PcepGlobalConfig(1) [lindex [stc::get $Project(1) -children-PcepGlobalConfig] 0]


set ResultDataSet(1) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {Port} \
        -Identifier {Port Traffic\Basic Traffic Results} \
        -Path {Port Traffic} \
        -Description {object://core/Port} \
        -CustomDisplayPath {Port Traffic and Counters} \
        -Name {Basic Traffic Results} ]

set ResultQuery(1) [stc::create "ResultQuery" \
        -under $ResultDataSet(1) \
        -ConfigClassId "generator" \
        -ResultClassId "generatorportresults" \
        -PropertyIdArray "generatorportresults.totalframecount generatorportresults.totaloctetcount generatorportresults.generatorframecount generatorportresults.generatoroctetcount generatorportresults.generatorsigframecount generatorportresults.generatorundersizeframecount generatorportresults.generatoroversizeframecount generatorportresults.generatorjumboframecount generatorportresults.totalframerate generatorportresults.totaloctetrate generatorportresults.generatorframerate generatorportresults.generatoroctetrate generatorportresults.generatorsigframerate generatorportresults.generatorundersizeframerate generatorportresults.generatoroversizeframerate generatorportresults.generatorjumboframerate generatorportresults.generatorcrcerrorframecount generatorportresults.generatorl3checksumerrorcount generatorportresults.generatorl4checksumerrorcount generatorportresults.generatorcrcerrorframerate generatorportresults.generatorl3checksumerrorrate generatorportresults.generatorl4checksumerrorrate generatorportresults.totalipv4framecount generatorportresults.totalipv6framecount generatorportresults.totalmplsframecount generatorportresults.generatoripv4framecount generatorportresults.generatoripv6framecount generatorportresults.generatorvlanframecount generatorportresults.generatormplsframecount generatorportresults.totalipv4framerate generatorportresults.totalipv6framerate generatorportresults.totalmplsframerate generatorportresults.generatoripv4framerate generatorportresults.generatoripv6framerate generatorportresults.generatorvlanframerate generatorportresults.generatormplsframerate generatorportresults.totalbitrate generatorportresults.generatorbitrate generatorportresults.l1bitcount generatorportresults.l1bitrate generatorportresults.pfcframecount generatorportresults.pfcpri0framecount generatorportresults.pfcpri1framecount generatorportresults.pfcpri2framecount generatorportresults.pfcpri3framecount generatorportresults.pfcpri4framecount generatorportresults.pfcpri5framecount generatorportresults.pfcpri6framecount generatorportresults.pfcpri7framecount generatorportresults.l1bitratepercent" ]

set ResultQuery(2) [stc::create "ResultQuery" \
        -under $ResultDataSet(1) \
        -ConfigClassId "analyzer" \
        -ResultClassId "analyzerportresults" \
        -PropertyIdArray "analyzerportresults.totalframecount analyzerportresults.totaloctetcount analyzerportresults.sigframecount analyzerportresults.undersizeframecount analyzerportresults.oversizeframecount analyzerportresults.jumboframecount analyzerportresults.minframelength analyzerportresults.maxframelength analyzerportresults.pauseframecount analyzerportresults.totalframerate analyzerportresults.totaloctetrate analyzerportresults.sigframerate analyzerportresults.undersizeframerate analyzerportresults.oversizeframerate analyzerportresults.jumboframerate analyzerportresults.pauseframerate analyzerportresults.fcserrorframecount analyzerportresults.ipv4checksumerrorcount analyzerportresults.tcpchecksumerrorcount analyzerportresults.udpchecksumerrorcount analyzerportresults.prbsfilloctetcount analyzerportresults.prbsbiterrorcount analyzerportresults.fcserrorframerate analyzerportresults.ipv4checksumerrorrate analyzerportresults.tcpchecksumerrorrate analyzerportresults.udpchecksumerrorrate analyzerportresults.prbsfilloctetrate analyzerportresults.prbsbiterrorrate analyzerportresults.ipv4framecount analyzerportresults.ipv6framecount analyzerportresults.ipv6overipv4framecount analyzerportresults.tcpframecount analyzerportresults.udpframecount analyzerportresults.mplsframecount analyzerportresults.icmpframecount analyzerportresults.vlanframecount analyzerportresults.ipv4framerate analyzerportresults.ipv6framerate analyzerportresults.ipv6overipv4framerate analyzerportresults.tcpframerate analyzerportresults.udpframerate analyzerportresults.mplsframerate analyzerportresults.icmpframerate analyzerportresults.vlanframerate analyzerportresults.trigger1count analyzerportresults.trigger1rate analyzerportresults.trigger2count analyzerportresults.trigger2rate analyzerportresults.trigger3count analyzerportresults.trigger3rate analyzerportresults.trigger4count analyzerportresults.trigger4rate analyzerportresults.trigger5count analyzerportresults.trigger5rate analyzerportresults.trigger6count analyzerportresults.trigger6rate analyzerportresults.trigger7count analyzerportresults.trigger7rate analyzerportresults.trigger8count analyzerportresults.trigger8rate analyzerportresults.combotriggercount analyzerportresults.combotriggerrate analyzerportresults.totalbitrate analyzerportresults.prbsbiterrorratio analyzerportresults.vlanframerate analyzerportresults.l1bitcount analyzerportresults.l1bitrate analyzerportresults.pfcframecount analyzerportresults.fcoeframecount analyzerportresults.pfcframerate analyzerportresults.fcoeframerate analyzerportresults.pfcpri0framecount analyzerportresults.pfcpri1framecount analyzerportresults.pfcpri2framecount analyzerportresults.pfcpri3framecount analyzerportresults.pfcpri4framecount analyzerportresults.pfcpri5framecount analyzerportresults.pfcpri6framecount analyzerportresults.pfcpri7framecount analyzerportresults.pfcpri0quanta analyzerportresults.pfcpri1quanta analyzerportresults.pfcpri2quanta analyzerportresults.pfcpri3quanta analyzerportresults.pfcpri4quanta analyzerportresults.pfcpri5quanta analyzerportresults.pfcpri6quanta analyzerportresults.pfcpri7quanta analyzerportresults.prbserrorframecount analyzerportresults.prbserrorframerate analyzerportresults.userdefinedframecount1 analyzerportresults.userdefinedframerate1 analyzerportresults.userdefinedframecount2 analyzerportresults.userdefinedframerate2 analyzerportresults.userdefinedframecount3 analyzerportresults.userdefinedframerate3 analyzerportresults.userdefinedframecount4 analyzerportresults.userdefinedframerate4 analyzerportresults.userdefinedframecount5 analyzerportresults.userdefinedframerate5 analyzerportresults.userdefinedframecount6 analyzerportresults.userdefinedframerate6 analyzerportresults.l1bitratepercent analyzerportresults.outseqframecount analyzerportresults.preambletotalbytes analyzerportresults.preambleminlength analyzerportresults.preamblemaxlength analyzerportresults.droppedframecount analyzerportresults.inorderframecount analyzerportresults.reorderedframecount analyzerportresults.duplicateframecount analyzerportresults.lateframecount analyzerportresults.firstarrivaltime analyzerportresults.lastarrivaltime" ]

set RealTimeResultColumnDefinition(1) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {Port} \
        -ColumnPropertyName {PortName} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(2) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "92" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(3) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "92" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(4) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalBitCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(5) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TotalBitCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(6) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalBitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(7) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TotalBitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "123" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(8) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {L1BitCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(9) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {L1BitCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(10) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {L1BitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(11) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {L1BitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(12) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {L1BitRatePercent} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "3" ]

set RealTimeResultColumnDefinition(13) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {L1BitRatePercent} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "3" ]

set RealTimeResultColumnDefinition(14) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "148" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(15) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorSigFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "167" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(16) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {SigFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "130" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(17) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "111" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(18) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "111" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(19) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "120" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(20) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOctetRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "123" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(21) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorBitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "131" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(22) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorSigFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "139" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(23) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {SigFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "102" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(24) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcsErrorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "197" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(25) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorCrcErrorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "201" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(26) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL3ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(27) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL4ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(28) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "171" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(29) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "168" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(30) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "170" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(31) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsFillOctetCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "148" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(32) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "137" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(33) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorRatio} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(34) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcsErrorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "134" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(35) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorCrcErrorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "172" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(36) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL3ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "230" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(37) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL4ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "230" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(38) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "164" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(39) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "162" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(40) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "163" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(41) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "169" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(42) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger1Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(43) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger2Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(44) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger3Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(45) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger4Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(46) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger5Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(47) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger6Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(48) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger7Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(49) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger8Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(50) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {ComboTriggerCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "87" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(51) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger1Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(52) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger2Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(53) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger3Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(54) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger4Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(55) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger5Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(56) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger6Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(57) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger7Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(58) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger8Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(59) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {ComboTriggerRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "114" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(60) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "86" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(61) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "88" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(62) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalMplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "91" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(63) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "129" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(64) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(65) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorVlanFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(66) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorMplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "132" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(67) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(68) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "124" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(69) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(70) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "120" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(71) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {MplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(72) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {IcmpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(73) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {VlanFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "113" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(74) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "87" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(75) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcoeFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "96" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(76) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv4FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "99" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(1) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {All Groups} \
        -GroupId {core://allgroups/} \
        -ColumnClassName {Port} \
        -ColumnPropertyName {PortName} ]

set RealTimeResultColumnDefinition(77) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv6FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "101" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(2) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Basic Counters} \
        -GroupId {object://customgroup/cded8621-5e71-4a39-afd4-71d9faf37273/Basic Counters} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount TotalBitCount TotalBitCount TotalBitRate TotalBitRate L1BitCount L1BitCount L1BitRate L1BitRate L1BitRatePercent L1BitRatePercent GeneratorFrameCount GeneratorSigFrameCount SigFrameCount TotalFrameRate TotalFrameRate GeneratorFrameRate GeneratorOctetRate GeneratorBitRate GeneratorSigFrameRate SigFrameRate} \
        -SqlString { SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', GeneratorPortResults.GeneratorFrameCount AS 'Generator Count (Frames)', GeneratorPortResults.GeneratorSigFrameCount AS 'Generator Sig Count (Frames)', AnalyzerPortResults.SigFrameCount AS 'Rx Sig Count (Frames)', (GeneratorPortResults.TotalOctetCount * 8) AS 'Total Tx  Count (bits)', (AnalyzerPortResults.TotalOctetCount * 8) AS 'Total Rx Count (bits)', GeneratorPortResults.L1BitCount AS 'Tx L1 Count (bits)', AnalyzerPortResults.L1BitCount AS 'Rx L1 Count (bits)', AnalyzerPortResults.MinFrameLength AS 'Rx Min FrameLength', AnalyzerPortResults.MaxFrameLength AS 'Rx Max FrameLength', GeneratorPortResults.TotalCellCount AS 'Total Tx Count (Cells)', AnalyzerPortResults.TotalCellCount AS 'Total Rx Count (Cells)' FROM Port, GeneratorPortResults, Generator, AnalyzerPortResults, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(3) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Errors} \
        -GroupId {object://customgroup/e26c15e5-fb73-46ad-a76b-45304a4e6303/Errors} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount FcsErrorFrameCount GeneratorCrcErrorFrameCount GeneratorL3ChecksumErrorCount GeneratorL4ChecksumErrorCount Ipv4ChecksumErrorCount TcpChecksumErrorCount UdpChecksumErrorCount PrbsFillOctetCount PrbsBitErrorCount PrbsBitErrorRatio PrbsErrorFrameCount FcsErrorFrameRate GeneratorCrcErrorFrameRate GeneratorL3ChecksumErrorRate GeneratorL4ChecksumErrorRate Ipv4ChecksumErrorRate TcpChecksumErrorRate UdpChecksumErrorRate PrbsBitErrorRate PrbsErrorFrameRate OutSeqFrameCount} \
        -SqlString { SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', AnalyzerPortResults.FcsErrorFrameCount AS 'Rx FCS Error Count (Frames)', GeneratorPortResults.GeneratorCrcErrorFrameCount AS 'Generator CRC Error Count (Frames)', GeneratorPortResults.GeneratorL3ChecksumErrorCount AS 'Generator L3 Checksum Error Count', GeneratorPortResults.GeneratorL4ChecksumErrorCount AS 'Generator L4 Checksum Error Count', AnalyzerPortResults.Ipv4ChecksumErrorCount AS 'Rx IPv4 Checksum Error Count', AnalyzerPortResults.TcpChecksumErrorCount AS 'Rx TCP Checksum Error Count', AnalyzerPortResults.UdpChecksumErrorCount AS 'Rx UDP Checksum Error Count', AnalyzerPortResults.PrbsFillOctetCount AS 'Rx PRBS Fill Octet Count', AnalyzerPortResults.PrbsBitErrorCount AS 'Rx PRBS Bit Error Count', coalesce(round(cast(AnalyzerPortResults.PrbsBitErrorCount as double)/cast((AnalyzerPortResults.PrbsFillOctetCount * 8) as double), 3), 0.0) as 'PRBS Bit Error Ratio', AnalyzerPortResults.PrbsErrorFrameCount AS 'Rx PRBS Error Frame Count' FROM Port, GeneratorPortResults, Generator, AnalyzerPortResults, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(4) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Triggers} \
        -GroupId {object://customgroup/ddcfebff-9e2d-49e4-8d4a-1cde4792f3c1/Triggers} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount Trigger1Count Trigger2Count Trigger3Count Trigger4Count Trigger5Count Trigger6Count Trigger7Count Trigger8Count ComboTriggerCount Trigger1Rate Trigger2Rate Trigger3Rate Trigger4Rate Trigger5Rate Trigger6Rate Trigger7Rate Trigger8Rate ComboTriggerRate} \
        -SqlString {SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', AnalyzerPortResults.Trigger1Count AS 'Trigger 1', AnalyzerPortResults.Trigger2Count AS 'Trigger 2', AnalyzerPortResults.Trigger3Count AS 'Trigger 3', AnalyzerPortResults.Trigger4Count AS 'Trigger 4', AnalyzerPortResults.Trigger5Count AS 'Trigger 5', AnalyzerPortResults.Trigger6Count AS 'Trigger 6', AnalyzerPortResults.Trigger7Count AS 'Trigger 7', AnalyzerPortResults.Trigger8Count AS 'Trigger 8', AnalyzerPortResults.ComboTriggerCount AS 'ComboTrigger', AnalyzerPortResults.Trigger1Rate AS 'Trigger 1 Rate', AnalyzerPortResults.Trigger2Rate AS 'Trigger 2 Rate', AnalyzerPortResults.Trigger3Rate AS 'Trigger 3 Rate', AnalyzerPortResults.Trigger4Rate AS 'Trigger 4 Rate', AnalyzerPortResults.Trigger5Rate AS 'Trigger 5 Rate', AnalyzerPortResults.Trigger6Rate AS 'Trigger 6 Rate', AnalyzerPortResults.Trigger7Rate AS 'Trigger 7 Rate', AnalyzerPortResults.Trigger8Rate AS 'Trigger 8 Rate', AnalyzerPortResults.ComboTriggerRate AS 'ComboTrigger Rate' FROM Port, GeneratorPortResults, AnalyzerPortResults, Generator, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) UNION SELECT ExternalDevicePort.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', AnalyzerPortResults.Trigger1Count AS 'Trigger 1', AnalyzerPortResults.Trigger2Count AS 'Trigger 2', AnalyzerPortResults.Trigger3Count AS 'Trigger 3', AnalyzerPortResults.Trigger4Count AS 'Trigger 4', AnalyzerPortResults.Trigger5Count AS 'Trigger 5', AnalyzerPortResults.Trigger6Count AS 'Trigger 6', AnalyzerPortResults.Trigger7Count AS 'Trigger 7', AnalyzerPortResults.Trigger8Count AS 'Trigger 8', AnalyzerPortResults.ComboTriggerCount AS 'ComboTrigger', AnalyzerPortResults.Trigger1Rate AS 'Trigger 1 Rate', AnalyzerPortResults.Trigger2Rate AS 'Trigger 2 Rate', AnalyzerPortResults.Trigger3Rate AS 'Trigger 3 Rate', AnalyzerPortResults.Trigger4Rate AS 'Trigger 4 Rate', AnalyzerPortResults.Trigger5Rate AS 'Trigger 5 Rate', AnalyzerPortResults.Trigger6Rate AS 'Trigger 6 Rate', AnalyzerPortResults.Trigger7Rate AS 'Trigger 7 Rate', AnalyzerPortResults.Trigger8Rate AS 'Trigger 8 Rate', AnalyzerPortResults.ComboTriggerRate AS 'ComboTrigger Rate' FROM ExternalDevicePort, GeneratorPortResults, AnalyzerPortResults, Port, Generator, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND ExternalDevicePort.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Port.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) } ]

set RealTimeResultGroupDefinition(5) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Protocols} \
        -GroupId {object://customgroup/3e090a0e-d3c7-413f-ad01-ccb4a21de519/Protocols} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount TotalIpv4FrameCount TotalIpv6FrameCount TotalMplsFrameCount GeneratorIpv4FrameCount GeneratorIpv6FrameCount GeneratorVlanFrameCount GeneratorMplsFrameCount Ipv4FrameCount Ipv6FrameCount TcpFrameCount UdpFrameCount MplsFrameCount IcmpFrameCount VlanFrameCount FcoeFrameCount TotalIpv4FrameRate TotalIpv6FrameRate TotalMplsFrameRate GeneratorIpv4FrameRate GeneratorIpv6FrameRate GeneratorVlanFrameRate GeneratorMplsFrameRate Ipv4FrameRate Ipv6FrameRate TcpFrameRate UdpFrameRate MplsFrameRate IcmpFrameRate VlanFrameRate FcoeFrameRate} \
        -SqlString { SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Frame Count', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Frame Count', GeneratorPortResults.TotalIpv4FrameCount AS 'Total Tx IPv4 Frame', GeneratorPortResults.TotalIpv6FrameCount AS 'Total Tx IPv6 Frame', GeneratorPortResults.TotalMplsFrameCount AS 'Total Tx MPLS Frame', GeneratorPortResults.GeneratorIpv4FrameCount AS 'Generator IPv4 Frame Count', GeneratorPortResults.GeneratorIpv6FrameCount AS 'Generator IPv6 Frame Count', GeneratorPortResults.GeneratorVlanFrameCount AS 'Generator VLAN Frame Count', GeneratorPortResults.GeneratorMplsFrameCount AS 'Generator MPLS Frame Count', AnalyzerPortResults.Ipv4FrameCount AS 'Rx IPv4 Frame Count', AnalyzerPortResults.Ipv6FrameCount AS 'Rx IPv6 Frame Count', AnalyzerPortResults.TcpFrameCount AS 'Rx TCP Frame Count', AnalyzerPortResults.UdpFrameCount AS 'Rx UDP Frame Count', AnalyzerPortResults.MplsFrameCount AS 'Rx MPLS Frame Count', AnalyzerPortResults.IcmpFrameCount AS 'Rx ICMP Frame Count', AnalyzerPortResults.VlanFrameCount AS 'Rx VLAN Frame Count', AnalyzerPortResults.FcoeFrameCount AS 'Rx FCoE Frame Count' FROM Port, GeneratorPortResults, Generator, AnalyzerPortResults, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultColumnDefinition(78) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalMplsFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "90" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(79) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv4FrameRate} \
        -ColumnWidth "115" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(80) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv6FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(81) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorVlanFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(82) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorMplsFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(83) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "114" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(84) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv6FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(85) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpFrameRate} \
        -ColumnWidth "77" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(86) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpFrameRate} \
        -ColumnWidth "84" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(87) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {MplsFrameRate} \
        -ColumnWidth "86" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(88) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {IcmpFrameRate} \
        -ColumnWidth "79" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(89) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {VlanFrameRate} \
        -ColumnWidth "113" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(6) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Undersize/Oversize/Jumbo} \
        -GroupId {object://customgroup/06ce5837-a7ee-427b-96e8-10cca3ff961a/Undersize/Oversize/Jumbo} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount GeneratorUndersizeFrameCount UndersizeFrameCount GeneratorOversizeFrameCount OversizeFrameCount GeneratorJumboFrameCount JumboFrameCount PauseFrameCount GeneratorUndersizeFrameRate UndersizeFrameRate GeneratorOversizeFrameRate OversizeFrameRate GeneratorJumboFrameRate JumboFrameRate PauseFrameRate} \
        -SqlString {SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', GeneratorPortResults.GeneratorUndersizeFrameCount AS 'Generator Undersize Count (Frames)', AnalyzerPortResults.UndersizeFrameCount AS 'Rx Undersize Frame Count (Frames)', GeneratorPortResults.GeneratorOversizeFrameCount AS 'Generator Oversize Count (Frames)', AnalyzerPortResults.OversizeFrameCount AS 'Rx Oversize Frame Count (Frames)', GeneratorPortResults.GeneratorJumboFrameCount AS 'Generator Jumbo Count (Frames)', AnalyzerPortResults.JumboFrameCount AS 'Rx Jumbo Frame Count (Frames)', AnalyzerPortResults.PauseFrameCount AS 'Rx Pause Frame Count (Frames)', GeneratorPortResults.GeneratorUndersizeFrameRate AS 'Generator Undersize Rate (fps)', AnalyzerPortResults.UndersizeFrameRate AS 'Rx Undersize Rate (fps)', GeneratorPortResults.GeneratorOversizeFrameRate AS 'Generator Oversize Rate (fps)', AnalyzerPortResults.OversizeFrameRate AS 'Rx Oversize Rate (fps)', GeneratorPortResults.GeneratorJumboFrameRate AS 'Generator Jumbo Frame Rate (fps)', AnalyzerPortResults.JumboFrameRate AS 'Rx Jumbo Rate (fps)', AnalyzerPortResults.PauseFrameRate AS 'Rx Pause Rate (fps)' FROM Port, GeneratorPortResults, AnalyzerPortResults, Generator, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) UNION SELECT ExternalDevicePort.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', GeneratorPortResults.GeneratorUndersizeFrameCount AS 'Generator Undersize Count (Frames)', AnalyzerPortResults.UndersizeFrameCount AS 'Rx Undersize Frame Count (Frames)', GeneratorPortResults.GeneratorOversizeFrameCount AS 'Generator Oversize Count (Frames)', AnalyzerPortResults.OversizeFrameCount AS 'Rx Oversize Frame Count (Frames)', GeneratorPortResults.GeneratorJumboFrameCount AS 'Generator Jumbo Count (Frames)', AnalyzerPortResults.JumboFrameCount AS 'Rx Jumbo Frame Count (Frames)', AnalyzerPortResults.PauseFrameCount AS 'Rx Pause Frame Count (Frames)', GeneratorPortResults.GeneratorUndersizeFrameRate AS 'Generator Undersize Rate (fps)', AnalyzerPortResults.UndersizeFrameRate AS 'Rx Undersize Rate (fps)', GeneratorPortResults.GeneratorOversizeFrameRate AS 'Generator Oversize Rate (fps)', AnalyzerPortResults.OversizeFrameRate AS 'Rx Oversize Rate (fps)', GeneratorPortResults.GeneratorJumboFrameRate AS 'Generator Jumbo Frame Rate (fps)', AnalyzerPortResults.JumboFrameRate AS 'Rx Jumbo Rate (fps)', AnalyzerPortResults.PauseFrameRate AS 'Rx Pause Rate (fps)' FROM ExternalDevicePort, GeneratorPortResults, AnalyzerPortResults, Port, Generator, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND ExternalDevicePort.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Port.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) } ]

set RealTimeResultColumnDefinition(90) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcFrameRate} \
        -ColumnWidth "93" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(91) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcoeFrameRate} \
        -ColumnWidth "93" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(92) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorUndersizeFrameCount} \
        -ColumnWidth "200" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(93) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UndersizeFrameCount} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(94) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOversizeFrameCount} \
        -ColumnWidth "194" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(95) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {OversizeFrameCount} \
        -ColumnWidth "192" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(96) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorJumboFrameCount} \
        -ColumnWidth "185" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(97) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {JumboFrameCount} \
        -ColumnWidth "182" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(98) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PauseFrameCount} \
        -ColumnWidth "179" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(99) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorUndersizeFrameRate} \
        -ColumnWidth "172" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(100) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UndersizeFrameRate} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(101) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOversizeFrameRate} \
        -ColumnWidth "166" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(102) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {OversizeFrameRate} \
        -ColumnWidth "129" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(103) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorJumboFrameRate} \
        -ColumnWidth "191" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(104) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {JumboFrameRate} \
        -ColumnWidth "119" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(105) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PauseFrameRate} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(106) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcFrameCount} \
        -ColumnWidth "96" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(107) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri0FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(108) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri1FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(109) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri2FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(110) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri3FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(111) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri4FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(112) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri5FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(113) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri6FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(114) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri7FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(115) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri0FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(116) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri1FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(117) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri2FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(118) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri3FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(119) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri4FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(120) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri5FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(121) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri6FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(122) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri7FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(7) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {PFC Counters} \
        -GroupId {object://customgroup/ce2848b9-5f04-419d-8809-030032c630e4/PFC Counters} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {PfcFrameCount PfcFrameCount PfcFrameRate PfcPri0FrameCount PfcPri1FrameCount PfcPri2FrameCount PfcPri3FrameCount PfcPri4FrameCount PfcPri5FrameCount PfcPri6FrameCount PfcPri7FrameCount PfcPri0FrameCount PfcPri1FrameCount PfcPri2FrameCount PfcPri3FrameCount PfcPri4FrameCount PfcPri5FrameCount PfcPri6FrameCount PfcPri7FrameCount} \
        -SqlString {SELECT Port.Name AS 'Port Name', GeneratorPortResults.PfcFrameCount AS 'Tx PFC Count (Frames)', AnalyzerPortResults.PfcFrameCount AS 'Rx PFC Count (Frames)', GeneratorPortResults.PfcPri0FrameCount AS 'Tx PFC Priority0 Count (Frames)', GeneratorPortResults.PfcPri1FrameCount AS 'Tx PFC Priority1 Count (Frames)', GeneratorPortResults.PfcPri2FrameCount AS 'Tx PFC Priority2 Count (Frames)', GeneratorPortResults.PfcPri3FrameCount AS 'Tx PFC Priority3 Count (Frames)', GeneratorPortResults.PfcPri4FrameCount AS 'Tx PFC Priority4 Count (Frames)', GeneratorPortResults.PfcPri5FrameCount AS 'Tx PFC Priority5 Count (Frames)', GeneratorPortResults.PfcPri6FrameCount AS 'Tx PFC Priority6 Count (Frames)', GeneratorPortResults.PfcPri7FrameCount AS 'Tx PFC Priority7 Count (Frames)', AnalyzerPortResults.PfcPri0FrameCount AS 'Rx PFC Priority0 Count (Frames)', AnalyzerPortResults.PfcPri1FrameCount AS 'Rx PFC Priority1 Count (Frames)', AnalyzerPortResults.PfcPri2FrameCount AS 'Rx PFC Priority2 Count (Frames)', AnalyzerPortResults.PfcPri3FrameCount AS 'Rx PFC Priority3 Count (Frames)', AnalyzerPortResults.PfcPri4FrameCount AS 'Rx PFC Priority4 Count (Frames)', AnalyzerPortResults.PfcPri5FrameCount AS 'Rx PFC Priority5 Count (Frames)', AnalyzerPortResults.PfcPri6FrameCount AS 'Rx PFC Priority6 Count (Frames)', AnalyzerPortResults.PfcPri7FrameCount AS 'Rx PFC Priority7 Count (Frames)', AnalyzerPortResults.PfcPri0Quanta AS 'Rx PFC Priority0 Quanta', AnalyzerPortResults.PfcPri1Quanta AS 'Rx PFC Priority1 Quanta', AnalyzerPortResults.PfcPri2Quanta AS 'Rx PFC Priority2 Quanta', AnalyzerPortResults.PfcPri3Quanta AS 'Rx PFC Priority3 Quanta', AnalyzerPortResults.PfcPri4Quanta AS 'Rx PFC Priority4 Quanta', AnalyzerPortResults.PfcPri5Quanta AS 'Rx PFC Priority5 Quanta', AnalyzerPortResults.PfcPri6Quanta AS 'Rx PFC Priority6 Quanta', AnalyzerPortResults.PfcPri7Quanta AS 'Rx PFC Priority7 Quanta' FROM Port, GeneratorPortResults, AnalyzerPortResults, Generator, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultColumnDefinition(123) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsErrorFrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(124) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {OutSeqFrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(125) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsErrorFrameRate} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(126) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount1} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(127) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate1} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(128) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount2} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(129) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate2} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(130) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount3} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(131) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate3} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(132) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount4} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(133) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate4} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(134) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount5} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(135) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate5} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(136) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount6} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(137) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate6} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(8) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {User Defined} \
        -GroupId {object://customgroup/45684926-5012-4d7b-a560-70e552840cbb/User Defined} \
        -ColumnClassName {AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount1 UserDefinedFrameRate1 UserDefinedFrameCount2 UserDefinedFrameRate2 UserDefinedFrameCount3 UserDefinedFrameRate3 UserDefinedFrameCount4 UserDefinedFrameRate4 UserDefinedFrameCount5 UserDefinedFrameRate5 UserDefinedFrameCount6 UserDefinedFrameRate6} \
        -SqlString {SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', AnalyzerPortResults.UserDefinedFrameCount1 AS 'User Defined Capture Frame Count 1 (Frames)', AnalyzerPortResults.UserDefinedFrameCount2 AS 'User Defined Capture Frame Count 2 (Frames)', AnalyzerPortResults.UserDefinedFrameCount3 AS 'User Defined Capture Frame Count 3 (Frames)', AnalyzerPortResults.UserDefinedFrameCount4 AS 'User Defined Capture Frame Count 4 (Frames)', AnalyzerPortResults.UserDefinedFrameCount5 AS 'User Defined Capture Frame Count 5 (Frames)', AnalyzerPortResults.UserDefinedFrameCount6 AS 'User Defined Capture Frame Count 6 (Frames)'  FROM Port, GeneratorPortResults, Generator, AnalyzerPortResults, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultColumnDefinition(138) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {InOrderFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(139) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {ReorderedFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(140) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {DroppedFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(141) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {DuplicateFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(142) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {LateFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(9) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Advanced Sequencing} \
        -GroupId {object://customgroup/d775c482-4220-4044-b3d8-d0980146f9dc/Advanced Sequencing} \
        -ColumnClassName {AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {DroppedFrameCount InOrderFrameCount ReorderedFrameCount DuplicateFrameCount LateFrameCount} \
        -SqlString {SELECT Port.Name AS 'Port Name', AnalyzerPortResults.DroppedFrameCount AS 'Dropped Count (Frames)', AnalyzerPortResults.InOrderFrameCount AS 'In-order Count (Frames)', AnalyzerPortResults.ReorderedFrameCount AS 'Reordered Count (Frames)', AnalyzerPortResults.DuplicateFrameCount AS 'Duplicate Count (Frames)', AnalyzerPortResults.LateFrameCount AS 'Late Count (Frames)' FROM Port, AnalyzerPortResults, Analyzer WHERE ( Analyzer.ParentHnd = Port.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) UNION SELECT ExternalDevicePort.Name AS 'Port Name', AnalyzerPortResults.DroppedFrameCount AS 'Dropped Count (Frames)', AnalyzerPortResults.InOrderFrameCount AS 'In-order Count (Frames)', AnalyzerPortResults.ReorderedFrameCount AS 'Reordered Count (Frames)', AnalyzerPortResults.DuplicateFrameCount AS 'Duplicate Count (Frames)', AnalyzerPortResults.LateFrameCount AS 'Late Count (Frames)' FROM ExternalDevicePort, AnalyzerPortResults, Port, Analyzer WHERE ( Analyzer.ParentHnd = Port.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND ExternalDevicePort.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Port.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  ) } ]

set Perspective(1) [stc::create "Perspective" \
        -under $Project(1) ]

set PerspectiveNode(1) [stc::create "PerspectiveNode" \
        -under $Perspective(1) \
        -Guid {8CF0ABC3-9F7C-46bd-A22E-00D88A8376D3} \
        -Data {<NodeData Name="resultFrame.1" FrameId="8CF0ABC3-9F7C-46bd-A22E-00D88A8376D3" Active="true" RowCount="1" ColumnCount="2" />} \
        -ContentData {<ContentData><NodeContentData FrameName="frame://core/Port/ResultQuery:(1, 0, 0)" ResultDataSetId="Port Traffic\Basic Traffic Results" Column="0" Row="0" DockPanelNumber="1" /><NodeContentData FrameName="frame://core/DynamicResultView/ResultQuery:(1, 0, 1)" ResultDataSetId="Port Traffic and Counters\Aggregate Port L1 Tx Rate" Column="1" Row="0" DockPanelNumber="1" /></ContentData> 
} ]

set PerspectiveNode(2) [stc::create "PerspectiveNode" \
        -under $Perspective(1) \
        -Guid {1F412EE6-760C-4937-9644-ACFA463EA44E} \
        -Data {<NodeData Name="resultFrame.2" FrameId="1F412EE6-760C-4937-9644-ACFA463EA44E" Active="false" RowCount="1" ColumnCount="2" />} \
        -ContentData {<ContentData /> 
} ]

set DynamicResultView(1) [stc::create "DynamicResultView" \
        -under $Project(1) \
        -ResultSourceClass {Port} \
        -Identifier {Port Traffic and Counters\Aggregate Port L1 Tx Rate} \
        -Path {Port Traffic} \
        -Description {object://core/DynamicResultView} \
        -CustomDisplayPath {Port Traffic and Counters} \
        -Name {Aggregate Port L1 Tx Rate} ]

set PresentationResultQuery(1) [stc::create "PresentationResultQuery" \
        -under $DynamicResultView(1) \
        -SelectProperties {Port.TxL1BitRate Port.TxMaxLineRate Project.Name} \
        -WhereConditions {} \
        -GroupByProperties {Project.Name} \
        -LimitSize "2000" \
        -SortBy {} ]

set ColumnDisplayProperties(1) [stc::create "ColumnDisplayProperties" \
        -under $DynamicResultView(1) \
        -ColumnPropertyId {Port.TxL1BitRate} \
        -ColumnCaption {Tx L1 Rate} \
        -ColumnUnits "5" \
        -ColumnGroups {} ]

set ColumnDisplayProperties(2) [stc::create "ColumnDisplayProperties" \
        -under $DynamicResultView(1) \
        -ColumnPropertyId {Port.TxMaxLineRate} \
        -ColumnCaption {Tx Max Line Rate} \
        -ColumnUnits "5" \
        -ColumnGroups {} ]

set ColumnDisplayProperties(3) [stc::create "ColumnDisplayProperties" \
        -under $DynamicResultView(1) \
        -ColumnPropertyId {Project.Name} \
        -ColumnCaption {Project Name} \
        -ColumnUnits "5" \
        -ColumnGroups {} ]

set Host(1) [lindex [stc::get $Port(1) -children-Host] 0]


set EthIIIf(1) [stc::create "EthIIIf" \
        -under $Host(1) \
        -SrcMacList "" ]

set HdlcIf(1) [stc::create "HdlcIf" \
        -under $Host(1) ]

set PppIf(1) [stc::create "PppIf" \
        -under $Host(1) ]

set PppIf(2) [stc::create "PppIf" \
        -under $Host(1) ]

set Ipv4If(1) [stc::create "Ipv4If" \
        -under $Host(1) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(1) [stc::create "Ipv6If" \
        -under $Host(1) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(2) [stc::create "Ipv6If" \
        -under $Host(1) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(1) [lindex [stc::get $Port(1) -children-Generator] 0]


set GeneratorConfig(1) [lindex [stc::get $Generator(1) -children-GeneratorConfig] 0]


set Analyzer(1) [lindex [stc::get $Port(1) -children-Analyzer] 0]


set AnalyzerConfig(1) [lindex [stc::get $Analyzer(1) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-JitterHistogram] 0]
stc::config $JitterHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(1) [lindex [stc::get $Analyzer(1) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(1) [lindex [stc::get $Analyzer(1) -children-HighResolutionSamplingPortConfig] 0]


set Capture(1) [lindex [stc::get $Port(1) -children-Capture] 0]


set CaptureFilter(1) [lindex [stc::get $Capture(1) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(1) [lindex [stc::get $Capture(1) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(1) [lindex [stc::get $Capture(1) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(1) [lindex [stc::get $Capture(1) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(1) [lindex [stc::get $Capture(1) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(1) [lindex [stc::get $Port(1) -children-IgmpPortConfig] 0]


set MldPortConfig(1) [lindex [stc::get $Port(1) -children-MldPortConfig] 0]


set ArpCache(1) [lindex [stc::get $Port(1) -children-ArpCache] 0]


set ArpNdReport(1) [lindex [stc::get $Port(1) -children-ArpNdReport] 0]


set PingReport(1) [lindex [stc::get $Port(1) -children-PingReport] 0]


set OsePortConfig(1) [lindex [stc::get $Port(1) -children-OsePortConfig] 0]


set OvsdbPortConfig(1) [lindex [stc::get $Port(1) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(1) \
        -CaCertificates {}

set VxlanPortConfig(1) [lindex [stc::get $Port(1) -children-VxlanPortConfig] 0]


set StpPortConfig(1) [lindex [stc::get $Port(1) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(1) [lindex [stc::get $Port(1) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(1) [lindex [stc::get $Port(1) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(1) [lindex [stc::get $Port(1) -children-SaaPortConfig] 0]


set L2tpPortConfig(1) [lindex [stc::get $Port(1) -children-L2tpPortConfig] 0]


set PppoxPortConfig(1) [lindex [stc::get $Port(1) -children-PppoxPortConfig] 0]


set PppProtocolConfig(1) [lindex [stc::get $Port(1) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(1) \
        -Protocol "PPPOPOS"

set AncpPortConfig(1) [lindex [stc::get $Port(1) -children-AncpPortConfig] 0]


set EoamPortConfig(1) [lindex [stc::get $Port(1) -children-EoamPortConfig] 0]


set AppPerfPortConfig(1) [lindex [stc::get $Port(1) -children-AppPerfPortConfig] 0]


set VqAnalyzer(1) [lindex [stc::get $Port(1) -children-VqAnalyzer] 0]


set EthernetCopper(1) [stc::create "EthernetCopper" \
        -under $Port(1) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(1) [lindex [stc::get $EthernetCopper(1) -children-Mii] 0]


set MiiRegister(1) [lindex [stc::get $Mii(1) -children-MiiRegister] 0]
stc::config $MiiRegister(1) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(2) [lindex [stc::get $Mii(1) -children-MiiRegister] 1]
stc::config $MiiRegister(2) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(3) [lindex [stc::get $Mii(1) -children-MiiRegister] 2]
stc::config $MiiRegister(3) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(4) [lindex [stc::get $Mii(1) -children-MiiRegister] 3]
stc::config $MiiRegister(4) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(5) [lindex [stc::get $Mii(1) -children-MiiRegister] 4]
stc::config $MiiRegister(5) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(6) [lindex [stc::get $Mii(1) -children-MiiRegister] 5]
stc::config $MiiRegister(6) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(7) [lindex [stc::get $Mii(1) -children-MiiRegister] 6]
stc::config $MiiRegister(7) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(8) [lindex [stc::get $Mii(1) -children-MiiRegister] 7]
stc::config $MiiRegister(8) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(9) [lindex [stc::get $Mii(1) -children-MiiRegister] 8]
stc::config $MiiRegister(9) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(10) [lindex [stc::get $Mii(1) -children-MiiRegister] 9]
stc::config $MiiRegister(10) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(11) [lindex [stc::get $Mii(1) -children-MiiRegister] 10]
stc::config $MiiRegister(11) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(12) [lindex [stc::get $Mii(1) -children-MiiRegister] 11]
stc::config $MiiRegister(12) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(13) [lindex [stc::get $Mii(1) -children-MiiRegister] 12]
stc::config $MiiRegister(13) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(14) [lindex [stc::get $Mii(1) -children-MiiRegister] 13]
stc::config $MiiRegister(14) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(15) [lindex [stc::get $Mii(1) -children-MiiRegister] 14]
stc::config $MiiRegister(15) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(16) [lindex [stc::get $Mii(1) -children-MiiRegister] 15]
stc::config $MiiRegister(16) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(17) [lindex [stc::get $Mii(1) -children-MiiRegister] 16]
stc::config $MiiRegister(17) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(18) [lindex [stc::get $Mii(1) -children-MiiRegister] 17]
stc::config $MiiRegister(18) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(19) [lindex [stc::get $Mii(1) -children-MiiRegister] 18]
stc::config $MiiRegister(19) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(20) [lindex [stc::get $Mii(1) -children-MiiRegister] 19]
stc::config $MiiRegister(20) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(21) [lindex [stc::get $Mii(1) -children-MiiRegister] 20]
stc::config $MiiRegister(21) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(22) [lindex [stc::get $Mii(1) -children-MiiRegister] 21]
stc::config $MiiRegister(22) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(23) [lindex [stc::get $Mii(1) -children-MiiRegister] 22]
stc::config $MiiRegister(23) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(24) [lindex [stc::get $Mii(1) -children-MiiRegister] 23]
stc::config $MiiRegister(24) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(25) [lindex [stc::get $Mii(1) -children-MiiRegister] 24]
stc::config $MiiRegister(25) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(26) [lindex [stc::get $Mii(1) -children-MiiRegister] 25]
stc::config $MiiRegister(26) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(27) [lindex [stc::get $Mii(1) -children-MiiRegister] 26]
stc::config $MiiRegister(27) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(28) [lindex [stc::get $Mii(1) -children-MiiRegister] 27]
stc::config $MiiRegister(28) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(29) [lindex [stc::get $Mii(1) -children-MiiRegister] 28]
stc::config $MiiRegister(29) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(30) [lindex [stc::get $Mii(1) -children-MiiRegister] 29]
stc::config $MiiRegister(30) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(31) [lindex [stc::get $Mii(1) -children-MiiRegister] 30]
stc::config $MiiRegister(31) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(32) [lindex [stc::get $Mii(1) -children-MiiRegister] 31]
stc::config $MiiRegister(32) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(2) [stc::create "EthernetCopper" \
        -under $Port(1) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(2) [lindex [stc::get $EthernetCopper(2) -children-Mii] 0]


set MiiRegister(33) [lindex [stc::get $Mii(2) -children-MiiRegister] 0]
stc::config $MiiRegister(33) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(34) [lindex [stc::get $Mii(2) -children-MiiRegister] 1]
stc::config $MiiRegister(34) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(35) [lindex [stc::get $Mii(2) -children-MiiRegister] 2]
stc::config $MiiRegister(35) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(36) [lindex [stc::get $Mii(2) -children-MiiRegister] 3]
stc::config $MiiRegister(36) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(37) [lindex [stc::get $Mii(2) -children-MiiRegister] 4]
stc::config $MiiRegister(37) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(38) [lindex [stc::get $Mii(2) -children-MiiRegister] 5]
stc::config $MiiRegister(38) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(39) [lindex [stc::get $Mii(2) -children-MiiRegister] 6]
stc::config $MiiRegister(39) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(40) [lindex [stc::get $Mii(2) -children-MiiRegister] 7]
stc::config $MiiRegister(40) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(41) [lindex [stc::get $Mii(2) -children-MiiRegister] 8]
stc::config $MiiRegister(41) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(42) [lindex [stc::get $Mii(2) -children-MiiRegister] 9]
stc::config $MiiRegister(42) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(43) [lindex [stc::get $Mii(2) -children-MiiRegister] 10]
stc::config $MiiRegister(43) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(44) [lindex [stc::get $Mii(2) -children-MiiRegister] 11]
stc::config $MiiRegister(44) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(45) [lindex [stc::get $Mii(2) -children-MiiRegister] 12]
stc::config $MiiRegister(45) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(46) [lindex [stc::get $Mii(2) -children-MiiRegister] 13]
stc::config $MiiRegister(46) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(47) [lindex [stc::get $Mii(2) -children-MiiRegister] 14]
stc::config $MiiRegister(47) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(48) [lindex [stc::get $Mii(2) -children-MiiRegister] 15]
stc::config $MiiRegister(48) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(49) [lindex [stc::get $Mii(2) -children-MiiRegister] 16]
stc::config $MiiRegister(49) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(50) [lindex [stc::get $Mii(2) -children-MiiRegister] 17]
stc::config $MiiRegister(50) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(51) [lindex [stc::get $Mii(2) -children-MiiRegister] 18]
stc::config $MiiRegister(51) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(52) [lindex [stc::get $Mii(2) -children-MiiRegister] 19]
stc::config $MiiRegister(52) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(53) [lindex [stc::get $Mii(2) -children-MiiRegister] 20]
stc::config $MiiRegister(53) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(54) [lindex [stc::get $Mii(2) -children-MiiRegister] 21]
stc::config $MiiRegister(54) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(55) [lindex [stc::get $Mii(2) -children-MiiRegister] 22]
stc::config $MiiRegister(55) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(56) [lindex [stc::get $Mii(2) -children-MiiRegister] 23]
stc::config $MiiRegister(56) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(57) [lindex [stc::get $Mii(2) -children-MiiRegister] 24]
stc::config $MiiRegister(57) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(58) [lindex [stc::get $Mii(2) -children-MiiRegister] 25]
stc::config $MiiRegister(58) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(59) [lindex [stc::get $Mii(2) -children-MiiRegister] 26]
stc::config $MiiRegister(59) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(60) [lindex [stc::get $Mii(2) -children-MiiRegister] 27]
stc::config $MiiRegister(60) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(61) [lindex [stc::get $Mii(2) -children-MiiRegister] 28]
stc::config $MiiRegister(61) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(62) [lindex [stc::get $Mii(2) -children-MiiRegister] 29]
stc::config $MiiRegister(62) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(63) [lindex [stc::get $Mii(2) -children-MiiRegister] 30]
stc::config $MiiRegister(63) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(64) [lindex [stc::get $Mii(2) -children-MiiRegister] 31]
stc::config $MiiRegister(64) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(2) [lindex [stc::get $Port(2) -children-Host] 0]


set EthIIIf(2) [stc::create "EthIIIf" \
        -under $Host(2) \
        -SrcMacList "" ]

set HdlcIf(2) [stc::create "HdlcIf" \
        -under $Host(2) ]

set PppIf(3) [stc::create "PppIf" \
        -under $Host(2) ]

set PppIf(4) [stc::create "PppIf" \
        -under $Host(2) ]

set Ipv4If(2) [stc::create "Ipv4If" \
        -under $Host(2) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(3) [stc::create "Ipv6If" \
        -under $Host(2) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(4) [stc::create "Ipv6If" \
        -under $Host(2) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(2) [lindex [stc::get $Port(2) -children-Generator] 0]


set GeneratorConfig(2) [lindex [stc::get $Generator(2) -children-GeneratorConfig] 0]


set Analyzer(2) [lindex [stc::get $Port(2) -children-Analyzer] 0]


set AnalyzerConfig(2) [lindex [stc::get $Analyzer(2) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-JitterHistogram] 0]
stc::config $JitterHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(2) [lindex [stc::get $Analyzer(2) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(2) [lindex [stc::get $Analyzer(2) -children-HighResolutionSamplingPortConfig] 0]


set Capture(2) [lindex [stc::get $Port(2) -children-Capture] 0]


set CaptureFilter(2) [lindex [stc::get $Capture(2) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(2) [lindex [stc::get $Capture(2) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(2) [lindex [stc::get $Capture(2) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(2) [lindex [stc::get $Capture(2) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(2) [lindex [stc::get $Capture(2) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(2) [lindex [stc::get $Port(2) -children-IgmpPortConfig] 0]


set MldPortConfig(2) [lindex [stc::get $Port(2) -children-MldPortConfig] 0]


set ArpCache(2) [lindex [stc::get $Port(2) -children-ArpCache] 0]


set ArpNdReport(2) [lindex [stc::get $Port(2) -children-ArpNdReport] 0]


set PingReport(2) [lindex [stc::get $Port(2) -children-PingReport] 0]


set OsePortConfig(2) [lindex [stc::get $Port(2) -children-OsePortConfig] 0]


set OvsdbPortConfig(2) [lindex [stc::get $Port(2) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(2) \
        -CaCertificates {}

set VxlanPortConfig(2) [lindex [stc::get $Port(2) -children-VxlanPortConfig] 0]


set StpPortConfig(2) [lindex [stc::get $Port(2) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(2) [lindex [stc::get $Port(2) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(2) [lindex [stc::get $Port(2) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(2) [lindex [stc::get $Port(2) -children-SaaPortConfig] 0]


set L2tpPortConfig(2) [lindex [stc::get $Port(2) -children-L2tpPortConfig] 0]


set PppoxPortConfig(2) [lindex [stc::get $Port(2) -children-PppoxPortConfig] 0]


set PppProtocolConfig(2) [lindex [stc::get $Port(2) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(2) \
        -Protocol "PPPOPOS"

set AncpPortConfig(2) [lindex [stc::get $Port(2) -children-AncpPortConfig] 0]


set EoamPortConfig(2) [lindex [stc::get $Port(2) -children-EoamPortConfig] 0]


set AppPerfPortConfig(2) [lindex [stc::get $Port(2) -children-AppPerfPortConfig] 0]


set VqAnalyzer(2) [lindex [stc::get $Port(2) -children-VqAnalyzer] 0]


set EthernetCopper(3) [stc::create "EthernetCopper" \
        -under $Port(2) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(3) [lindex [stc::get $EthernetCopper(3) -children-Mii] 0]


set MiiRegister(65) [lindex [stc::get $Mii(3) -children-MiiRegister] 0]
stc::config $MiiRegister(65) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(66) [lindex [stc::get $Mii(3) -children-MiiRegister] 1]
stc::config $MiiRegister(66) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(67) [lindex [stc::get $Mii(3) -children-MiiRegister] 2]
stc::config $MiiRegister(67) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(68) [lindex [stc::get $Mii(3) -children-MiiRegister] 3]
stc::config $MiiRegister(68) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(69) [lindex [stc::get $Mii(3) -children-MiiRegister] 4]
stc::config $MiiRegister(69) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(70) [lindex [stc::get $Mii(3) -children-MiiRegister] 5]
stc::config $MiiRegister(70) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(71) [lindex [stc::get $Mii(3) -children-MiiRegister] 6]
stc::config $MiiRegister(71) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(72) [lindex [stc::get $Mii(3) -children-MiiRegister] 7]
stc::config $MiiRegister(72) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(73) [lindex [stc::get $Mii(3) -children-MiiRegister] 8]
stc::config $MiiRegister(73) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(74) [lindex [stc::get $Mii(3) -children-MiiRegister] 9]
stc::config $MiiRegister(74) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(75) [lindex [stc::get $Mii(3) -children-MiiRegister] 10]
stc::config $MiiRegister(75) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(76) [lindex [stc::get $Mii(3) -children-MiiRegister] 11]
stc::config $MiiRegister(76) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(77) [lindex [stc::get $Mii(3) -children-MiiRegister] 12]
stc::config $MiiRegister(77) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(78) [lindex [stc::get $Mii(3) -children-MiiRegister] 13]
stc::config $MiiRegister(78) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(79) [lindex [stc::get $Mii(3) -children-MiiRegister] 14]
stc::config $MiiRegister(79) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(80) [lindex [stc::get $Mii(3) -children-MiiRegister] 15]
stc::config $MiiRegister(80) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(81) [lindex [stc::get $Mii(3) -children-MiiRegister] 16]
stc::config $MiiRegister(81) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(82) [lindex [stc::get $Mii(3) -children-MiiRegister] 17]
stc::config $MiiRegister(82) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(83) [lindex [stc::get $Mii(3) -children-MiiRegister] 18]
stc::config $MiiRegister(83) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(84) [lindex [stc::get $Mii(3) -children-MiiRegister] 19]
stc::config $MiiRegister(84) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(85) [lindex [stc::get $Mii(3) -children-MiiRegister] 20]
stc::config $MiiRegister(85) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(86) [lindex [stc::get $Mii(3) -children-MiiRegister] 21]
stc::config $MiiRegister(86) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(87) [lindex [stc::get $Mii(3) -children-MiiRegister] 22]
stc::config $MiiRegister(87) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(88) [lindex [stc::get $Mii(3) -children-MiiRegister] 23]
stc::config $MiiRegister(88) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(89) [lindex [stc::get $Mii(3) -children-MiiRegister] 24]
stc::config $MiiRegister(89) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(90) [lindex [stc::get $Mii(3) -children-MiiRegister] 25]
stc::config $MiiRegister(90) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(91) [lindex [stc::get $Mii(3) -children-MiiRegister] 26]
stc::config $MiiRegister(91) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(92) [lindex [stc::get $Mii(3) -children-MiiRegister] 27]
stc::config $MiiRegister(92) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(93) [lindex [stc::get $Mii(3) -children-MiiRegister] 28]
stc::config $MiiRegister(93) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(94) [lindex [stc::get $Mii(3) -children-MiiRegister] 29]
stc::config $MiiRegister(94) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(95) [lindex [stc::get $Mii(3) -children-MiiRegister] 30]
stc::config $MiiRegister(95) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(96) [lindex [stc::get $Mii(3) -children-MiiRegister] 31]
stc::config $MiiRegister(96) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(4) [stc::create "EthernetCopper" \
        -under $Port(2) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(4) [lindex [stc::get $EthernetCopper(4) -children-Mii] 0]


set MiiRegister(97) [lindex [stc::get $Mii(4) -children-MiiRegister] 0]
stc::config $MiiRegister(97) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(98) [lindex [stc::get $Mii(4) -children-MiiRegister] 1]
stc::config $MiiRegister(98) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(99) [lindex [stc::get $Mii(4) -children-MiiRegister] 2]
stc::config $MiiRegister(99) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(100) [lindex [stc::get $Mii(4) -children-MiiRegister] 3]
stc::config $MiiRegister(100) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(101) [lindex [stc::get $Mii(4) -children-MiiRegister] 4]
stc::config $MiiRegister(101) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(102) [lindex [stc::get $Mii(4) -children-MiiRegister] 5]
stc::config $MiiRegister(102) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(103) [lindex [stc::get $Mii(4) -children-MiiRegister] 6]
stc::config $MiiRegister(103) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(104) [lindex [stc::get $Mii(4) -children-MiiRegister] 7]
stc::config $MiiRegister(104) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(105) [lindex [stc::get $Mii(4) -children-MiiRegister] 8]
stc::config $MiiRegister(105) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(106) [lindex [stc::get $Mii(4) -children-MiiRegister] 9]
stc::config $MiiRegister(106) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(107) [lindex [stc::get $Mii(4) -children-MiiRegister] 10]
stc::config $MiiRegister(107) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(108) [lindex [stc::get $Mii(4) -children-MiiRegister] 11]
stc::config $MiiRegister(108) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(109) [lindex [stc::get $Mii(4) -children-MiiRegister] 12]
stc::config $MiiRegister(109) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(110) [lindex [stc::get $Mii(4) -children-MiiRegister] 13]
stc::config $MiiRegister(110) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(111) [lindex [stc::get $Mii(4) -children-MiiRegister] 14]
stc::config $MiiRegister(111) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(112) [lindex [stc::get $Mii(4) -children-MiiRegister] 15]
stc::config $MiiRegister(112) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(113) [lindex [stc::get $Mii(4) -children-MiiRegister] 16]
stc::config $MiiRegister(113) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(114) [lindex [stc::get $Mii(4) -children-MiiRegister] 17]
stc::config $MiiRegister(114) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(115) [lindex [stc::get $Mii(4) -children-MiiRegister] 18]
stc::config $MiiRegister(115) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(116) [lindex [stc::get $Mii(4) -children-MiiRegister] 19]
stc::config $MiiRegister(116) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(117) [lindex [stc::get $Mii(4) -children-MiiRegister] 20]
stc::config $MiiRegister(117) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(118) [lindex [stc::get $Mii(4) -children-MiiRegister] 21]
stc::config $MiiRegister(118) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(119) [lindex [stc::get $Mii(4) -children-MiiRegister] 22]
stc::config $MiiRegister(119) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(120) [lindex [stc::get $Mii(4) -children-MiiRegister] 23]
stc::config $MiiRegister(120) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(121) [lindex [stc::get $Mii(4) -children-MiiRegister] 24]
stc::config $MiiRegister(121) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(122) [lindex [stc::get $Mii(4) -children-MiiRegister] 25]
stc::config $MiiRegister(122) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(123) [lindex [stc::get $Mii(4) -children-MiiRegister] 26]
stc::config $MiiRegister(123) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(124) [lindex [stc::get $Mii(4) -children-MiiRegister] 27]
stc::config $MiiRegister(124) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(125) [lindex [stc::get $Mii(4) -children-MiiRegister] 28]
stc::config $MiiRegister(125) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(126) [lindex [stc::get $Mii(4) -children-MiiRegister] 29]
stc::config $MiiRegister(126) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(127) [lindex [stc::get $Mii(4) -children-MiiRegister] 30]
stc::config $MiiRegister(127) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(128) [lindex [stc::get $Mii(4) -children-MiiRegister] 31]
stc::config $MiiRegister(128) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(3) [lindex [stc::get $Port(3) -children-Host] 0]


set EthIIIf(3) [stc::create "EthIIIf" \
        -under $Host(3) \
        -SrcMacList "" ]

set HdlcIf(3) [stc::create "HdlcIf" \
        -under $Host(3) ]

set PppIf(5) [stc::create "PppIf" \
        -under $Host(3) ]

set PppIf(6) [stc::create "PppIf" \
        -under $Host(3) ]

set Ipv4If(3) [stc::create "Ipv4If" \
        -under $Host(3) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(5) [stc::create "Ipv6If" \
        -under $Host(3) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(6) [stc::create "Ipv6If" \
        -under $Host(3) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(3) [lindex [stc::get $Port(3) -children-Generator] 0]


set GeneratorConfig(3) [lindex [stc::get $Generator(3) -children-GeneratorConfig] 0]


set Analyzer(3) [lindex [stc::get $Port(3) -children-Analyzer] 0]


set AnalyzerConfig(3) [lindex [stc::get $Analyzer(3) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-JitterHistogram] 0]
stc::config $JitterHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(3) [lindex [stc::get $Analyzer(3) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(3) [lindex [stc::get $Analyzer(3) -children-HighResolutionSamplingPortConfig] 0]


set Capture(3) [lindex [stc::get $Port(3) -children-Capture] 0]


set CaptureFilter(3) [lindex [stc::get $Capture(3) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(3) [lindex [stc::get $Capture(3) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(3) [lindex [stc::get $Capture(3) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(3) [lindex [stc::get $Capture(3) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(3) [lindex [stc::get $Capture(3) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(3) [lindex [stc::get $Port(3) -children-IgmpPortConfig] 0]


set MldPortConfig(3) [lindex [stc::get $Port(3) -children-MldPortConfig] 0]


set ArpCache(3) [lindex [stc::get $Port(3) -children-ArpCache] 0]


set ArpNdReport(3) [lindex [stc::get $Port(3) -children-ArpNdReport] 0]


set PingReport(3) [lindex [stc::get $Port(3) -children-PingReport] 0]


set OsePortConfig(3) [lindex [stc::get $Port(3) -children-OsePortConfig] 0]


set OvsdbPortConfig(3) [lindex [stc::get $Port(3) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(3) \
        -CaCertificates {}

set VxlanPortConfig(3) [lindex [stc::get $Port(3) -children-VxlanPortConfig] 0]


set StpPortConfig(3) [lindex [stc::get $Port(3) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(3) [lindex [stc::get $Port(3) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(3) [lindex [stc::get $Port(3) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(3) [lindex [stc::get $Port(3) -children-SaaPortConfig] 0]


set L2tpPortConfig(3) [lindex [stc::get $Port(3) -children-L2tpPortConfig] 0]


set PppoxPortConfig(3) [lindex [stc::get $Port(3) -children-PppoxPortConfig] 0]


set PppProtocolConfig(3) [lindex [stc::get $Port(3) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(3) \
        -Protocol "PPPOPOS"

set AncpPortConfig(3) [lindex [stc::get $Port(3) -children-AncpPortConfig] 0]


set EoamPortConfig(3) [lindex [stc::get $Port(3) -children-EoamPortConfig] 0]


set AppPerfPortConfig(3) [lindex [stc::get $Port(3) -children-AppPerfPortConfig] 0]


set VqAnalyzer(3) [lindex [stc::get $Port(3) -children-VqAnalyzer] 0]


set EthernetCopper(5) [stc::create "EthernetCopper" \
        -under $Port(3) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(5) [lindex [stc::get $EthernetCopper(5) -children-Mii] 0]


set MiiRegister(129) [lindex [stc::get $Mii(5) -children-MiiRegister] 0]
stc::config $MiiRegister(129) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(130) [lindex [stc::get $Mii(5) -children-MiiRegister] 1]
stc::config $MiiRegister(130) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(131) [lindex [stc::get $Mii(5) -children-MiiRegister] 2]
stc::config $MiiRegister(131) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(132) [lindex [stc::get $Mii(5) -children-MiiRegister] 3]
stc::config $MiiRegister(132) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(133) [lindex [stc::get $Mii(5) -children-MiiRegister] 4]
stc::config $MiiRegister(133) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(134) [lindex [stc::get $Mii(5) -children-MiiRegister] 5]
stc::config $MiiRegister(134) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(135) [lindex [stc::get $Mii(5) -children-MiiRegister] 6]
stc::config $MiiRegister(135) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(136) [lindex [stc::get $Mii(5) -children-MiiRegister] 7]
stc::config $MiiRegister(136) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(137) [lindex [stc::get $Mii(5) -children-MiiRegister] 8]
stc::config $MiiRegister(137) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(138) [lindex [stc::get $Mii(5) -children-MiiRegister] 9]
stc::config $MiiRegister(138) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(139) [lindex [stc::get $Mii(5) -children-MiiRegister] 10]
stc::config $MiiRegister(139) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(140) [lindex [stc::get $Mii(5) -children-MiiRegister] 11]
stc::config $MiiRegister(140) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(141) [lindex [stc::get $Mii(5) -children-MiiRegister] 12]
stc::config $MiiRegister(141) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(142) [lindex [stc::get $Mii(5) -children-MiiRegister] 13]
stc::config $MiiRegister(142) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(143) [lindex [stc::get $Mii(5) -children-MiiRegister] 14]
stc::config $MiiRegister(143) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(144) [lindex [stc::get $Mii(5) -children-MiiRegister] 15]
stc::config $MiiRegister(144) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(145) [lindex [stc::get $Mii(5) -children-MiiRegister] 16]
stc::config $MiiRegister(145) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(146) [lindex [stc::get $Mii(5) -children-MiiRegister] 17]
stc::config $MiiRegister(146) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(147) [lindex [stc::get $Mii(5) -children-MiiRegister] 18]
stc::config $MiiRegister(147) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(148) [lindex [stc::get $Mii(5) -children-MiiRegister] 19]
stc::config $MiiRegister(148) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(149) [lindex [stc::get $Mii(5) -children-MiiRegister] 20]
stc::config $MiiRegister(149) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(150) [lindex [stc::get $Mii(5) -children-MiiRegister] 21]
stc::config $MiiRegister(150) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(151) [lindex [stc::get $Mii(5) -children-MiiRegister] 22]
stc::config $MiiRegister(151) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(152) [lindex [stc::get $Mii(5) -children-MiiRegister] 23]
stc::config $MiiRegister(152) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(153) [lindex [stc::get $Mii(5) -children-MiiRegister] 24]
stc::config $MiiRegister(153) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(154) [lindex [stc::get $Mii(5) -children-MiiRegister] 25]
stc::config $MiiRegister(154) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(155) [lindex [stc::get $Mii(5) -children-MiiRegister] 26]
stc::config $MiiRegister(155) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(156) [lindex [stc::get $Mii(5) -children-MiiRegister] 27]
stc::config $MiiRegister(156) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(157) [lindex [stc::get $Mii(5) -children-MiiRegister] 28]
stc::config $MiiRegister(157) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(158) [lindex [stc::get $Mii(5) -children-MiiRegister] 29]
stc::config $MiiRegister(158) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(159) [lindex [stc::get $Mii(5) -children-MiiRegister] 30]
stc::config $MiiRegister(159) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(160) [lindex [stc::get $Mii(5) -children-MiiRegister] 31]
stc::config $MiiRegister(160) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(6) [stc::create "EthernetCopper" \
        -under $Port(3) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(6) [lindex [stc::get $EthernetCopper(6) -children-Mii] 0]


set MiiRegister(161) [lindex [stc::get $Mii(6) -children-MiiRegister] 0]
stc::config $MiiRegister(161) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(162) [lindex [stc::get $Mii(6) -children-MiiRegister] 1]
stc::config $MiiRegister(162) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(163) [lindex [stc::get $Mii(6) -children-MiiRegister] 2]
stc::config $MiiRegister(163) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(164) [lindex [stc::get $Mii(6) -children-MiiRegister] 3]
stc::config $MiiRegister(164) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(165) [lindex [stc::get $Mii(6) -children-MiiRegister] 4]
stc::config $MiiRegister(165) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(166) [lindex [stc::get $Mii(6) -children-MiiRegister] 5]
stc::config $MiiRegister(166) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(167) [lindex [stc::get $Mii(6) -children-MiiRegister] 6]
stc::config $MiiRegister(167) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(168) [lindex [stc::get $Mii(6) -children-MiiRegister] 7]
stc::config $MiiRegister(168) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(169) [lindex [stc::get $Mii(6) -children-MiiRegister] 8]
stc::config $MiiRegister(169) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(170) [lindex [stc::get $Mii(6) -children-MiiRegister] 9]
stc::config $MiiRegister(170) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(171) [lindex [stc::get $Mii(6) -children-MiiRegister] 10]
stc::config $MiiRegister(171) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(172) [lindex [stc::get $Mii(6) -children-MiiRegister] 11]
stc::config $MiiRegister(172) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(173) [lindex [stc::get $Mii(6) -children-MiiRegister] 12]
stc::config $MiiRegister(173) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(174) [lindex [stc::get $Mii(6) -children-MiiRegister] 13]
stc::config $MiiRegister(174) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(175) [lindex [stc::get $Mii(6) -children-MiiRegister] 14]
stc::config $MiiRegister(175) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(176) [lindex [stc::get $Mii(6) -children-MiiRegister] 15]
stc::config $MiiRegister(176) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(177) [lindex [stc::get $Mii(6) -children-MiiRegister] 16]
stc::config $MiiRegister(177) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(178) [lindex [stc::get $Mii(6) -children-MiiRegister] 17]
stc::config $MiiRegister(178) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(179) [lindex [stc::get $Mii(6) -children-MiiRegister] 18]
stc::config $MiiRegister(179) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(180) [lindex [stc::get $Mii(6) -children-MiiRegister] 19]
stc::config $MiiRegister(180) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(181) [lindex [stc::get $Mii(6) -children-MiiRegister] 20]
stc::config $MiiRegister(181) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(182) [lindex [stc::get $Mii(6) -children-MiiRegister] 21]
stc::config $MiiRegister(182) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(183) [lindex [stc::get $Mii(6) -children-MiiRegister] 22]
stc::config $MiiRegister(183) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(184) [lindex [stc::get $Mii(6) -children-MiiRegister] 23]
stc::config $MiiRegister(184) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(185) [lindex [stc::get $Mii(6) -children-MiiRegister] 24]
stc::config $MiiRegister(185) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(186) [lindex [stc::get $Mii(6) -children-MiiRegister] 25]
stc::config $MiiRegister(186) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(187) [lindex [stc::get $Mii(6) -children-MiiRegister] 26]
stc::config $MiiRegister(187) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(188) [lindex [stc::get $Mii(6) -children-MiiRegister] 27]
stc::config $MiiRegister(188) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(189) [lindex [stc::get $Mii(6) -children-MiiRegister] 28]
stc::config $MiiRegister(189) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(190) [lindex [stc::get $Mii(6) -children-MiiRegister] 29]
stc::config $MiiRegister(190) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(191) [lindex [stc::get $Mii(6) -children-MiiRegister] 30]
stc::config $MiiRegister(191) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(192) [lindex [stc::get $Mii(6) -children-MiiRegister] 31]
stc::config $MiiRegister(192) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(4) [lindex [stc::get $Port(4) -children-Host] 0]


set EthIIIf(4) [stc::create "EthIIIf" \
        -under $Host(4) \
        -SrcMacList "" ]

set HdlcIf(4) [stc::create "HdlcIf" \
        -under $Host(4) ]

set PppIf(7) [stc::create "PppIf" \
        -under $Host(4) ]

set PppIf(8) [stc::create "PppIf" \
        -under $Host(4) ]

set Ipv4If(4) [stc::create "Ipv4If" \
        -under $Host(4) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(7) [stc::create "Ipv6If" \
        -under $Host(4) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(8) [stc::create "Ipv6If" \
        -under $Host(4) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(4) [lindex [stc::get $Port(4) -children-Generator] 0]


set GeneratorConfig(4) [lindex [stc::get $Generator(4) -children-GeneratorConfig] 0]


set Analyzer(4) [lindex [stc::get $Port(4) -children-Analyzer] 0]


set AnalyzerConfig(4) [lindex [stc::get $Analyzer(4) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(4) [lindex [stc::get $AnalyzerConfig(4) -children-JitterHistogram] 0]
stc::config $JitterHistogram(4) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(4) [lindex [stc::get $Analyzer(4) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(4) [lindex [stc::get $Analyzer(4) -children-HighResolutionSamplingPortConfig] 0]


set Capture(4) [lindex [stc::get $Port(4) -children-Capture] 0]


set CaptureFilter(4) [lindex [stc::get $Capture(4) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(4) [lindex [stc::get $Capture(4) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(4) [lindex [stc::get $Capture(4) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(4) [lindex [stc::get $Capture(4) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(4) [lindex [stc::get $Capture(4) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(4) [lindex [stc::get $Port(4) -children-IgmpPortConfig] 0]


set MldPortConfig(4) [lindex [stc::get $Port(4) -children-MldPortConfig] 0]


set ArpCache(4) [lindex [stc::get $Port(4) -children-ArpCache] 0]


set ArpNdReport(4) [lindex [stc::get $Port(4) -children-ArpNdReport] 0]


set PingReport(4) [lindex [stc::get $Port(4) -children-PingReport] 0]


set OsePortConfig(4) [lindex [stc::get $Port(4) -children-OsePortConfig] 0]


set OvsdbPortConfig(4) [lindex [stc::get $Port(4) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(4) \
        -CaCertificates {}

set VxlanPortConfig(4) [lindex [stc::get $Port(4) -children-VxlanPortConfig] 0]


set StpPortConfig(4) [lindex [stc::get $Port(4) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(4) [lindex [stc::get $Port(4) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(4) [lindex [stc::get $Port(4) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(4) [lindex [stc::get $Port(4) -children-SaaPortConfig] 0]


set L2tpPortConfig(4) [lindex [stc::get $Port(4) -children-L2tpPortConfig] 0]


set PppoxPortConfig(4) [lindex [stc::get $Port(4) -children-PppoxPortConfig] 0]


set PppProtocolConfig(4) [lindex [stc::get $Port(4) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(4) \
        -Protocol "PPPOPOS"

set AncpPortConfig(4) [lindex [stc::get $Port(4) -children-AncpPortConfig] 0]


set EoamPortConfig(4) [lindex [stc::get $Port(4) -children-EoamPortConfig] 0]


set AppPerfPortConfig(4) [lindex [stc::get $Port(4) -children-AppPerfPortConfig] 0]


set VqAnalyzer(4) [lindex [stc::get $Port(4) -children-VqAnalyzer] 0]


set EthernetCopper(7) [stc::create "EthernetCopper" \
        -under $Port(4) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(7) [lindex [stc::get $EthernetCopper(7) -children-Mii] 0]


set MiiRegister(193) [lindex [stc::get $Mii(7) -children-MiiRegister] 0]
stc::config $MiiRegister(193) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(194) [lindex [stc::get $Mii(7) -children-MiiRegister] 1]
stc::config $MiiRegister(194) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(195) [lindex [stc::get $Mii(7) -children-MiiRegister] 2]
stc::config $MiiRegister(195) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(196) [lindex [stc::get $Mii(7) -children-MiiRegister] 3]
stc::config $MiiRegister(196) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(197) [lindex [stc::get $Mii(7) -children-MiiRegister] 4]
stc::config $MiiRegister(197) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(198) [lindex [stc::get $Mii(7) -children-MiiRegister] 5]
stc::config $MiiRegister(198) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(199) [lindex [stc::get $Mii(7) -children-MiiRegister] 6]
stc::config $MiiRegister(199) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(200) [lindex [stc::get $Mii(7) -children-MiiRegister] 7]
stc::config $MiiRegister(200) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(201) [lindex [stc::get $Mii(7) -children-MiiRegister] 8]
stc::config $MiiRegister(201) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(202) [lindex [stc::get $Mii(7) -children-MiiRegister] 9]
stc::config $MiiRegister(202) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(203) [lindex [stc::get $Mii(7) -children-MiiRegister] 10]
stc::config $MiiRegister(203) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(204) [lindex [stc::get $Mii(7) -children-MiiRegister] 11]
stc::config $MiiRegister(204) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(205) [lindex [stc::get $Mii(7) -children-MiiRegister] 12]
stc::config $MiiRegister(205) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(206) [lindex [stc::get $Mii(7) -children-MiiRegister] 13]
stc::config $MiiRegister(206) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(207) [lindex [stc::get $Mii(7) -children-MiiRegister] 14]
stc::config $MiiRegister(207) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(208) [lindex [stc::get $Mii(7) -children-MiiRegister] 15]
stc::config $MiiRegister(208) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(209) [lindex [stc::get $Mii(7) -children-MiiRegister] 16]
stc::config $MiiRegister(209) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(210) [lindex [stc::get $Mii(7) -children-MiiRegister] 17]
stc::config $MiiRegister(210) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(211) [lindex [stc::get $Mii(7) -children-MiiRegister] 18]
stc::config $MiiRegister(211) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(212) [lindex [stc::get $Mii(7) -children-MiiRegister] 19]
stc::config $MiiRegister(212) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(213) [lindex [stc::get $Mii(7) -children-MiiRegister] 20]
stc::config $MiiRegister(213) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(214) [lindex [stc::get $Mii(7) -children-MiiRegister] 21]
stc::config $MiiRegister(214) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(215) [lindex [stc::get $Mii(7) -children-MiiRegister] 22]
stc::config $MiiRegister(215) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(216) [lindex [stc::get $Mii(7) -children-MiiRegister] 23]
stc::config $MiiRegister(216) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(217) [lindex [stc::get $Mii(7) -children-MiiRegister] 24]
stc::config $MiiRegister(217) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(218) [lindex [stc::get $Mii(7) -children-MiiRegister] 25]
stc::config $MiiRegister(218) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(219) [lindex [stc::get $Mii(7) -children-MiiRegister] 26]
stc::config $MiiRegister(219) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(220) [lindex [stc::get $Mii(7) -children-MiiRegister] 27]
stc::config $MiiRegister(220) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(221) [lindex [stc::get $Mii(7) -children-MiiRegister] 28]
stc::config $MiiRegister(221) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(222) [lindex [stc::get $Mii(7) -children-MiiRegister] 29]
stc::config $MiiRegister(222) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(223) [lindex [stc::get $Mii(7) -children-MiiRegister] 30]
stc::config $MiiRegister(223) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(224) [lindex [stc::get $Mii(7) -children-MiiRegister] 31]
stc::config $MiiRegister(224) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(8) [stc::create "EthernetCopper" \
        -under $Port(4) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(8) [lindex [stc::get $EthernetCopper(8) -children-Mii] 0]


set MiiRegister(225) [lindex [stc::get $Mii(8) -children-MiiRegister] 0]
stc::config $MiiRegister(225) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(226) [lindex [stc::get $Mii(8) -children-MiiRegister] 1]
stc::config $MiiRegister(226) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(227) [lindex [stc::get $Mii(8) -children-MiiRegister] 2]
stc::config $MiiRegister(227) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(228) [lindex [stc::get $Mii(8) -children-MiiRegister] 3]
stc::config $MiiRegister(228) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(229) [lindex [stc::get $Mii(8) -children-MiiRegister] 4]
stc::config $MiiRegister(229) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(230) [lindex [stc::get $Mii(8) -children-MiiRegister] 5]
stc::config $MiiRegister(230) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(231) [lindex [stc::get $Mii(8) -children-MiiRegister] 6]
stc::config $MiiRegister(231) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(232) [lindex [stc::get $Mii(8) -children-MiiRegister] 7]
stc::config $MiiRegister(232) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(233) [lindex [stc::get $Mii(8) -children-MiiRegister] 8]
stc::config $MiiRegister(233) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(234) [lindex [stc::get $Mii(8) -children-MiiRegister] 9]
stc::config $MiiRegister(234) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(235) [lindex [stc::get $Mii(8) -children-MiiRegister] 10]
stc::config $MiiRegister(235) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(236) [lindex [stc::get $Mii(8) -children-MiiRegister] 11]
stc::config $MiiRegister(236) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(237) [lindex [stc::get $Mii(8) -children-MiiRegister] 12]
stc::config $MiiRegister(237) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(238) [lindex [stc::get $Mii(8) -children-MiiRegister] 13]
stc::config $MiiRegister(238) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(239) [lindex [stc::get $Mii(8) -children-MiiRegister] 14]
stc::config $MiiRegister(239) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(240) [lindex [stc::get $Mii(8) -children-MiiRegister] 15]
stc::config $MiiRegister(240) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(241) [lindex [stc::get $Mii(8) -children-MiiRegister] 16]
stc::config $MiiRegister(241) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(242) [lindex [stc::get $Mii(8) -children-MiiRegister] 17]
stc::config $MiiRegister(242) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(243) [lindex [stc::get $Mii(8) -children-MiiRegister] 18]
stc::config $MiiRegister(243) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(244) [lindex [stc::get $Mii(8) -children-MiiRegister] 19]
stc::config $MiiRegister(244) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(245) [lindex [stc::get $Mii(8) -children-MiiRegister] 20]
stc::config $MiiRegister(245) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(246) [lindex [stc::get $Mii(8) -children-MiiRegister] 21]
stc::config $MiiRegister(246) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(247) [lindex [stc::get $Mii(8) -children-MiiRegister] 22]
stc::config $MiiRegister(247) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(248) [lindex [stc::get $Mii(8) -children-MiiRegister] 23]
stc::config $MiiRegister(248) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(249) [lindex [stc::get $Mii(8) -children-MiiRegister] 24]
stc::config $MiiRegister(249) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(250) [lindex [stc::get $Mii(8) -children-MiiRegister] 25]
stc::config $MiiRegister(250) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(251) [lindex [stc::get $Mii(8) -children-MiiRegister] 26]
stc::config $MiiRegister(251) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(252) [lindex [stc::get $Mii(8) -children-MiiRegister] 27]
stc::config $MiiRegister(252) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(253) [lindex [stc::get $Mii(8) -children-MiiRegister] 28]
stc::config $MiiRegister(253) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(254) [lindex [stc::get $Mii(8) -children-MiiRegister] 29]
stc::config $MiiRegister(254) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(255) [lindex [stc::get $Mii(8) -children-MiiRegister] 30]
stc::config $MiiRegister(255) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(256) [lindex [stc::get $Mii(8) -children-MiiRegister] 31]
stc::config $MiiRegister(256) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(5) [lindex [stc::get $Port(5) -children-Host] 0]


set EthIIIf(5) [stc::create "EthIIIf" \
        -under $Host(5) \
        -SrcMacList "" ]

set HdlcIf(5) [stc::create "HdlcIf" \
        -under $Host(5) ]

set PppIf(9) [stc::create "PppIf" \
        -under $Host(5) ]

set PppIf(10) [stc::create "PppIf" \
        -under $Host(5) ]

set Ipv4If(5) [stc::create "Ipv4If" \
        -under $Host(5) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(9) [stc::create "Ipv6If" \
        -under $Host(5) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(10) [stc::create "Ipv6If" \
        -under $Host(5) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(5) [lindex [stc::get $Port(5) -children-Generator] 0]


set GeneratorConfig(5) [lindex [stc::get $Generator(5) -children-GeneratorConfig] 0]


set Analyzer(5) [lindex [stc::get $Port(5) -children-Analyzer] 0]


set AnalyzerConfig(5) [lindex [stc::get $Analyzer(5) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(5) [lindex [stc::get $AnalyzerConfig(5) -children-JitterHistogram] 0]
stc::config $JitterHistogram(5) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(5) [lindex [stc::get $Analyzer(5) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(5) [lindex [stc::get $Analyzer(5) -children-HighResolutionSamplingPortConfig] 0]


set Capture(5) [lindex [stc::get $Port(5) -children-Capture] 0]


set CaptureFilter(5) [lindex [stc::get $Capture(5) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(5) [lindex [stc::get $Capture(5) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(5) [lindex [stc::get $Capture(5) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(5) [lindex [stc::get $Capture(5) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(5) [lindex [stc::get $Capture(5) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(5) [lindex [stc::get $Port(5) -children-IgmpPortConfig] 0]


set MldPortConfig(5) [lindex [stc::get $Port(5) -children-MldPortConfig] 0]


set ArpCache(5) [lindex [stc::get $Port(5) -children-ArpCache] 0]


set ArpNdReport(5) [lindex [stc::get $Port(5) -children-ArpNdReport] 0]


set PingReport(5) [lindex [stc::get $Port(5) -children-PingReport] 0]


set OsePortConfig(5) [lindex [stc::get $Port(5) -children-OsePortConfig] 0]


set OvsdbPortConfig(5) [lindex [stc::get $Port(5) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(5) \
        -CaCertificates {}

set VxlanPortConfig(5) [lindex [stc::get $Port(5) -children-VxlanPortConfig] 0]


set StpPortConfig(5) [lindex [stc::get $Port(5) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(5) [lindex [stc::get $Port(5) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(5) [lindex [stc::get $Port(5) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(5) [lindex [stc::get $Port(5) -children-SaaPortConfig] 0]


set L2tpPortConfig(5) [lindex [stc::get $Port(5) -children-L2tpPortConfig] 0]


set PppoxPortConfig(5) [lindex [stc::get $Port(5) -children-PppoxPortConfig] 0]


set PppProtocolConfig(5) [lindex [stc::get $Port(5) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(5) \
        -Protocol "PPPOPOS"

set AncpPortConfig(5) [lindex [stc::get $Port(5) -children-AncpPortConfig] 0]


set EoamPortConfig(5) [lindex [stc::get $Port(5) -children-EoamPortConfig] 0]


set AppPerfPortConfig(5) [lindex [stc::get $Port(5) -children-AppPerfPortConfig] 0]


set VqAnalyzer(5) [lindex [stc::get $Port(5) -children-VqAnalyzer] 0]


set EthernetCopper(9) [stc::create "EthernetCopper" \
        -under $Port(5) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(9) [lindex [stc::get $EthernetCopper(9) -children-Mii] 0]


set MiiRegister(257) [lindex [stc::get $Mii(9) -children-MiiRegister] 0]
stc::config $MiiRegister(257) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(258) [lindex [stc::get $Mii(9) -children-MiiRegister] 1]
stc::config $MiiRegister(258) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(259) [lindex [stc::get $Mii(9) -children-MiiRegister] 2]
stc::config $MiiRegister(259) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(260) [lindex [stc::get $Mii(9) -children-MiiRegister] 3]
stc::config $MiiRegister(260) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(261) [lindex [stc::get $Mii(9) -children-MiiRegister] 4]
stc::config $MiiRegister(261) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(262) [lindex [stc::get $Mii(9) -children-MiiRegister] 5]
stc::config $MiiRegister(262) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(263) [lindex [stc::get $Mii(9) -children-MiiRegister] 6]
stc::config $MiiRegister(263) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(264) [lindex [stc::get $Mii(9) -children-MiiRegister] 7]
stc::config $MiiRegister(264) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(265) [lindex [stc::get $Mii(9) -children-MiiRegister] 8]
stc::config $MiiRegister(265) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(266) [lindex [stc::get $Mii(9) -children-MiiRegister] 9]
stc::config $MiiRegister(266) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(267) [lindex [stc::get $Mii(9) -children-MiiRegister] 10]
stc::config $MiiRegister(267) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(268) [lindex [stc::get $Mii(9) -children-MiiRegister] 11]
stc::config $MiiRegister(268) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(269) [lindex [stc::get $Mii(9) -children-MiiRegister] 12]
stc::config $MiiRegister(269) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(270) [lindex [stc::get $Mii(9) -children-MiiRegister] 13]
stc::config $MiiRegister(270) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(271) [lindex [stc::get $Mii(9) -children-MiiRegister] 14]
stc::config $MiiRegister(271) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(272) [lindex [stc::get $Mii(9) -children-MiiRegister] 15]
stc::config $MiiRegister(272) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(273) [lindex [stc::get $Mii(9) -children-MiiRegister] 16]
stc::config $MiiRegister(273) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(274) [lindex [stc::get $Mii(9) -children-MiiRegister] 17]
stc::config $MiiRegister(274) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(275) [lindex [stc::get $Mii(9) -children-MiiRegister] 18]
stc::config $MiiRegister(275) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(276) [lindex [stc::get $Mii(9) -children-MiiRegister] 19]
stc::config $MiiRegister(276) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(277) [lindex [stc::get $Mii(9) -children-MiiRegister] 20]
stc::config $MiiRegister(277) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(278) [lindex [stc::get $Mii(9) -children-MiiRegister] 21]
stc::config $MiiRegister(278) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(279) [lindex [stc::get $Mii(9) -children-MiiRegister] 22]
stc::config $MiiRegister(279) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(280) [lindex [stc::get $Mii(9) -children-MiiRegister] 23]
stc::config $MiiRegister(280) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(281) [lindex [stc::get $Mii(9) -children-MiiRegister] 24]
stc::config $MiiRegister(281) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(282) [lindex [stc::get $Mii(9) -children-MiiRegister] 25]
stc::config $MiiRegister(282) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(283) [lindex [stc::get $Mii(9) -children-MiiRegister] 26]
stc::config $MiiRegister(283) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(284) [lindex [stc::get $Mii(9) -children-MiiRegister] 27]
stc::config $MiiRegister(284) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(285) [lindex [stc::get $Mii(9) -children-MiiRegister] 28]
stc::config $MiiRegister(285) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(286) [lindex [stc::get $Mii(9) -children-MiiRegister] 29]
stc::config $MiiRegister(286) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(287) [lindex [stc::get $Mii(9) -children-MiiRegister] 30]
stc::config $MiiRegister(287) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(288) [lindex [stc::get $Mii(9) -children-MiiRegister] 31]
stc::config $MiiRegister(288) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(10) [stc::create "EthernetCopper" \
        -under $Port(5) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(10) [lindex [stc::get $EthernetCopper(10) -children-Mii] 0]


set MiiRegister(289) [lindex [stc::get $Mii(10) -children-MiiRegister] 0]
stc::config $MiiRegister(289) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(290) [lindex [stc::get $Mii(10) -children-MiiRegister] 1]
stc::config $MiiRegister(290) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(291) [lindex [stc::get $Mii(10) -children-MiiRegister] 2]
stc::config $MiiRegister(291) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(292) [lindex [stc::get $Mii(10) -children-MiiRegister] 3]
stc::config $MiiRegister(292) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(293) [lindex [stc::get $Mii(10) -children-MiiRegister] 4]
stc::config $MiiRegister(293) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(294) [lindex [stc::get $Mii(10) -children-MiiRegister] 5]
stc::config $MiiRegister(294) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(295) [lindex [stc::get $Mii(10) -children-MiiRegister] 6]
stc::config $MiiRegister(295) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(296) [lindex [stc::get $Mii(10) -children-MiiRegister] 7]
stc::config $MiiRegister(296) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(297) [lindex [stc::get $Mii(10) -children-MiiRegister] 8]
stc::config $MiiRegister(297) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(298) [lindex [stc::get $Mii(10) -children-MiiRegister] 9]
stc::config $MiiRegister(298) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(299) [lindex [stc::get $Mii(10) -children-MiiRegister] 10]
stc::config $MiiRegister(299) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(300) [lindex [stc::get $Mii(10) -children-MiiRegister] 11]
stc::config $MiiRegister(300) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(301) [lindex [stc::get $Mii(10) -children-MiiRegister] 12]
stc::config $MiiRegister(301) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(302) [lindex [stc::get $Mii(10) -children-MiiRegister] 13]
stc::config $MiiRegister(302) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(303) [lindex [stc::get $Mii(10) -children-MiiRegister] 14]
stc::config $MiiRegister(303) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(304) [lindex [stc::get $Mii(10) -children-MiiRegister] 15]
stc::config $MiiRegister(304) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(305) [lindex [stc::get $Mii(10) -children-MiiRegister] 16]
stc::config $MiiRegister(305) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(306) [lindex [stc::get $Mii(10) -children-MiiRegister] 17]
stc::config $MiiRegister(306) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(307) [lindex [stc::get $Mii(10) -children-MiiRegister] 18]
stc::config $MiiRegister(307) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(308) [lindex [stc::get $Mii(10) -children-MiiRegister] 19]
stc::config $MiiRegister(308) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(309) [lindex [stc::get $Mii(10) -children-MiiRegister] 20]
stc::config $MiiRegister(309) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(310) [lindex [stc::get $Mii(10) -children-MiiRegister] 21]
stc::config $MiiRegister(310) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(311) [lindex [stc::get $Mii(10) -children-MiiRegister] 22]
stc::config $MiiRegister(311) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(312) [lindex [stc::get $Mii(10) -children-MiiRegister] 23]
stc::config $MiiRegister(312) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(313) [lindex [stc::get $Mii(10) -children-MiiRegister] 24]
stc::config $MiiRegister(313) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(314) [lindex [stc::get $Mii(10) -children-MiiRegister] 25]
stc::config $MiiRegister(314) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(315) [lindex [stc::get $Mii(10) -children-MiiRegister] 26]
stc::config $MiiRegister(315) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(316) [lindex [stc::get $Mii(10) -children-MiiRegister] 27]
stc::config $MiiRegister(316) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(317) [lindex [stc::get $Mii(10) -children-MiiRegister] 28]
stc::config $MiiRegister(317) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(318) [lindex [stc::get $Mii(10) -children-MiiRegister] 29]
stc::config $MiiRegister(318) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(319) [lindex [stc::get $Mii(10) -children-MiiRegister] 30]
stc::config $MiiRegister(319) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(320) [lindex [stc::get $Mii(10) -children-MiiRegister] 31]
stc::config $MiiRegister(320) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(6) [lindex [stc::get $Port(6) -children-Host] 0]


set EthIIIf(6) [stc::create "EthIIIf" \
        -under $Host(6) \
        -SrcMacList "" ]

set HdlcIf(6) [stc::create "HdlcIf" \
        -under $Host(6) ]

set PppIf(11) [stc::create "PppIf" \
        -under $Host(6) ]

set PppIf(12) [stc::create "PppIf" \
        -under $Host(6) ]

set Ipv4If(6) [stc::create "Ipv4If" \
        -under $Host(6) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(11) [stc::create "Ipv6If" \
        -under $Host(6) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(12) [stc::create "Ipv6If" \
        -under $Host(6) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(6) [lindex [stc::get $Port(6) -children-Generator] 0]


set GeneratorConfig(6) [lindex [stc::get $Generator(6) -children-GeneratorConfig] 0]


set Analyzer(6) [lindex [stc::get $Port(6) -children-Analyzer] 0]


set AnalyzerConfig(6) [lindex [stc::get $Analyzer(6) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(6) [lindex [stc::get $AnalyzerConfig(6) -children-JitterHistogram] 0]
stc::config $JitterHistogram(6) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(6) [lindex [stc::get $Analyzer(6) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(6) [lindex [stc::get $Analyzer(6) -children-HighResolutionSamplingPortConfig] 0]


set Capture(6) [lindex [stc::get $Port(6) -children-Capture] 0]


set CaptureFilter(6) [lindex [stc::get $Capture(6) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(6) [lindex [stc::get $Capture(6) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(6) [lindex [stc::get $Capture(6) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(6) [lindex [stc::get $Capture(6) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(6) [lindex [stc::get $Capture(6) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(6) [lindex [stc::get $Port(6) -children-IgmpPortConfig] 0]


set MldPortConfig(6) [lindex [stc::get $Port(6) -children-MldPortConfig] 0]


set ArpCache(6) [lindex [stc::get $Port(6) -children-ArpCache] 0]


set ArpNdReport(6) [lindex [stc::get $Port(6) -children-ArpNdReport] 0]


set PingReport(6) [lindex [stc::get $Port(6) -children-PingReport] 0]


set OsePortConfig(6) [lindex [stc::get $Port(6) -children-OsePortConfig] 0]


set OvsdbPortConfig(6) [lindex [stc::get $Port(6) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(6) \
        -CaCertificates {}

set VxlanPortConfig(6) [lindex [stc::get $Port(6) -children-VxlanPortConfig] 0]


set StpPortConfig(6) [lindex [stc::get $Port(6) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(6) [lindex [stc::get $Port(6) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(6) [lindex [stc::get $Port(6) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(6) [lindex [stc::get $Port(6) -children-SaaPortConfig] 0]


set L2tpPortConfig(6) [lindex [stc::get $Port(6) -children-L2tpPortConfig] 0]


set PppoxPortConfig(6) [lindex [stc::get $Port(6) -children-PppoxPortConfig] 0]


set PppProtocolConfig(6) [lindex [stc::get $Port(6) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(6) \
        -Protocol "PPPOPOS"

set AncpPortConfig(6) [lindex [stc::get $Port(6) -children-AncpPortConfig] 0]


set EoamPortConfig(6) [lindex [stc::get $Port(6) -children-EoamPortConfig] 0]


set AppPerfPortConfig(6) [lindex [stc::get $Port(6) -children-AppPerfPortConfig] 0]


set VqAnalyzer(6) [lindex [stc::get $Port(6) -children-VqAnalyzer] 0]


set EthernetCopper(11) [stc::create "EthernetCopper" \
        -under $Port(6) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(11) [lindex [stc::get $EthernetCopper(11) -children-Mii] 0]


set MiiRegister(321) [lindex [stc::get $Mii(11) -children-MiiRegister] 0]
stc::config $MiiRegister(321) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(322) [lindex [stc::get $Mii(11) -children-MiiRegister] 1]
stc::config $MiiRegister(322) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(323) [lindex [stc::get $Mii(11) -children-MiiRegister] 2]
stc::config $MiiRegister(323) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(324) [lindex [stc::get $Mii(11) -children-MiiRegister] 3]
stc::config $MiiRegister(324) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(325) [lindex [stc::get $Mii(11) -children-MiiRegister] 4]
stc::config $MiiRegister(325) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(326) [lindex [stc::get $Mii(11) -children-MiiRegister] 5]
stc::config $MiiRegister(326) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(327) [lindex [stc::get $Mii(11) -children-MiiRegister] 6]
stc::config $MiiRegister(327) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(328) [lindex [stc::get $Mii(11) -children-MiiRegister] 7]
stc::config $MiiRegister(328) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(329) [lindex [stc::get $Mii(11) -children-MiiRegister] 8]
stc::config $MiiRegister(329) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(330) [lindex [stc::get $Mii(11) -children-MiiRegister] 9]
stc::config $MiiRegister(330) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(331) [lindex [stc::get $Mii(11) -children-MiiRegister] 10]
stc::config $MiiRegister(331) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(332) [lindex [stc::get $Mii(11) -children-MiiRegister] 11]
stc::config $MiiRegister(332) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(333) [lindex [stc::get $Mii(11) -children-MiiRegister] 12]
stc::config $MiiRegister(333) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(334) [lindex [stc::get $Mii(11) -children-MiiRegister] 13]
stc::config $MiiRegister(334) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(335) [lindex [stc::get $Mii(11) -children-MiiRegister] 14]
stc::config $MiiRegister(335) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(336) [lindex [stc::get $Mii(11) -children-MiiRegister] 15]
stc::config $MiiRegister(336) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(337) [lindex [stc::get $Mii(11) -children-MiiRegister] 16]
stc::config $MiiRegister(337) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(338) [lindex [stc::get $Mii(11) -children-MiiRegister] 17]
stc::config $MiiRegister(338) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(339) [lindex [stc::get $Mii(11) -children-MiiRegister] 18]
stc::config $MiiRegister(339) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(340) [lindex [stc::get $Mii(11) -children-MiiRegister] 19]
stc::config $MiiRegister(340) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(341) [lindex [stc::get $Mii(11) -children-MiiRegister] 20]
stc::config $MiiRegister(341) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(342) [lindex [stc::get $Mii(11) -children-MiiRegister] 21]
stc::config $MiiRegister(342) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(343) [lindex [stc::get $Mii(11) -children-MiiRegister] 22]
stc::config $MiiRegister(343) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(344) [lindex [stc::get $Mii(11) -children-MiiRegister] 23]
stc::config $MiiRegister(344) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(345) [lindex [stc::get $Mii(11) -children-MiiRegister] 24]
stc::config $MiiRegister(345) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(346) [lindex [stc::get $Mii(11) -children-MiiRegister] 25]
stc::config $MiiRegister(346) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(347) [lindex [stc::get $Mii(11) -children-MiiRegister] 26]
stc::config $MiiRegister(347) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(348) [lindex [stc::get $Mii(11) -children-MiiRegister] 27]
stc::config $MiiRegister(348) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(349) [lindex [stc::get $Mii(11) -children-MiiRegister] 28]
stc::config $MiiRegister(349) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(350) [lindex [stc::get $Mii(11) -children-MiiRegister] 29]
stc::config $MiiRegister(350) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(351) [lindex [stc::get $Mii(11) -children-MiiRegister] 30]
stc::config $MiiRegister(351) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(352) [lindex [stc::get $Mii(11) -children-MiiRegister] 31]
stc::config $MiiRegister(352) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(12) [stc::create "EthernetCopper" \
        -under $Port(6) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(12) [lindex [stc::get $EthernetCopper(12) -children-Mii] 0]


set MiiRegister(353) [lindex [stc::get $Mii(12) -children-MiiRegister] 0]
stc::config $MiiRegister(353) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(354) [lindex [stc::get $Mii(12) -children-MiiRegister] 1]
stc::config $MiiRegister(354) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(355) [lindex [stc::get $Mii(12) -children-MiiRegister] 2]
stc::config $MiiRegister(355) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(356) [lindex [stc::get $Mii(12) -children-MiiRegister] 3]
stc::config $MiiRegister(356) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(357) [lindex [stc::get $Mii(12) -children-MiiRegister] 4]
stc::config $MiiRegister(357) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(358) [lindex [stc::get $Mii(12) -children-MiiRegister] 5]
stc::config $MiiRegister(358) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(359) [lindex [stc::get $Mii(12) -children-MiiRegister] 6]
stc::config $MiiRegister(359) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(360) [lindex [stc::get $Mii(12) -children-MiiRegister] 7]
stc::config $MiiRegister(360) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(361) [lindex [stc::get $Mii(12) -children-MiiRegister] 8]
stc::config $MiiRegister(361) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(362) [lindex [stc::get $Mii(12) -children-MiiRegister] 9]
stc::config $MiiRegister(362) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(363) [lindex [stc::get $Mii(12) -children-MiiRegister] 10]
stc::config $MiiRegister(363) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(364) [lindex [stc::get $Mii(12) -children-MiiRegister] 11]
stc::config $MiiRegister(364) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(365) [lindex [stc::get $Mii(12) -children-MiiRegister] 12]
stc::config $MiiRegister(365) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(366) [lindex [stc::get $Mii(12) -children-MiiRegister] 13]
stc::config $MiiRegister(366) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(367) [lindex [stc::get $Mii(12) -children-MiiRegister] 14]
stc::config $MiiRegister(367) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(368) [lindex [stc::get $Mii(12) -children-MiiRegister] 15]
stc::config $MiiRegister(368) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(369) [lindex [stc::get $Mii(12) -children-MiiRegister] 16]
stc::config $MiiRegister(369) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(370) [lindex [stc::get $Mii(12) -children-MiiRegister] 17]
stc::config $MiiRegister(370) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(371) [lindex [stc::get $Mii(12) -children-MiiRegister] 18]
stc::config $MiiRegister(371) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(372) [lindex [stc::get $Mii(12) -children-MiiRegister] 19]
stc::config $MiiRegister(372) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(373) [lindex [stc::get $Mii(12) -children-MiiRegister] 20]
stc::config $MiiRegister(373) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(374) [lindex [stc::get $Mii(12) -children-MiiRegister] 21]
stc::config $MiiRegister(374) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(375) [lindex [stc::get $Mii(12) -children-MiiRegister] 22]
stc::config $MiiRegister(375) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(376) [lindex [stc::get $Mii(12) -children-MiiRegister] 23]
stc::config $MiiRegister(376) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(377) [lindex [stc::get $Mii(12) -children-MiiRegister] 24]
stc::config $MiiRegister(377) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(378) [lindex [stc::get $Mii(12) -children-MiiRegister] 25]
stc::config $MiiRegister(378) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(379) [lindex [stc::get $Mii(12) -children-MiiRegister] 26]
stc::config $MiiRegister(379) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(380) [lindex [stc::get $Mii(12) -children-MiiRegister] 27]
stc::config $MiiRegister(380) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(381) [lindex [stc::get $Mii(12) -children-MiiRegister] 28]
stc::config $MiiRegister(381) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(382) [lindex [stc::get $Mii(12) -children-MiiRegister] 29]
stc::config $MiiRegister(382) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(383) [lindex [stc::get $Mii(12) -children-MiiRegister] 30]
stc::config $MiiRegister(383) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(384) [lindex [stc::get $Mii(12) -children-MiiRegister] 31]
stc::config $MiiRegister(384) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(7) [lindex [stc::get $Port(7) -children-Host] 0]


set EthIIIf(7) [stc::create "EthIIIf" \
        -under $Host(7) \
        -SrcMacList "" ]

set HdlcIf(7) [stc::create "HdlcIf" \
        -under $Host(7) ]

set PppIf(13) [stc::create "PppIf" \
        -under $Host(7) ]

set PppIf(14) [stc::create "PppIf" \
        -under $Host(7) ]

set Ipv4If(7) [stc::create "Ipv4If" \
        -under $Host(7) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(13) [stc::create "Ipv6If" \
        -under $Host(7) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(14) [stc::create "Ipv6If" \
        -under $Host(7) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(7) [lindex [stc::get $Port(7) -children-Generator] 0]


set GeneratorConfig(7) [lindex [stc::get $Generator(7) -children-GeneratorConfig] 0]


set Analyzer(7) [lindex [stc::get $Port(7) -children-Analyzer] 0]


set AnalyzerConfig(7) [lindex [stc::get $Analyzer(7) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(7) [lindex [stc::get $AnalyzerConfig(7) -children-JitterHistogram] 0]
stc::config $JitterHistogram(7) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(7) [lindex [stc::get $Analyzer(7) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(7) [lindex [stc::get $Analyzer(7) -children-HighResolutionSamplingPortConfig] 0]


set Capture(7) [lindex [stc::get $Port(7) -children-Capture] 0]


set CaptureFilter(7) [lindex [stc::get $Capture(7) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(7) [lindex [stc::get $Capture(7) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(7) [lindex [stc::get $Capture(7) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(7) [lindex [stc::get $Capture(7) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(7) [lindex [stc::get $Capture(7) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(7) [lindex [stc::get $Port(7) -children-IgmpPortConfig] 0]


set MldPortConfig(7) [lindex [stc::get $Port(7) -children-MldPortConfig] 0]


set ArpCache(7) [lindex [stc::get $Port(7) -children-ArpCache] 0]


set ArpNdReport(7) [lindex [stc::get $Port(7) -children-ArpNdReport] 0]


set PingReport(7) [lindex [stc::get $Port(7) -children-PingReport] 0]


set OsePortConfig(7) [lindex [stc::get $Port(7) -children-OsePortConfig] 0]


set OvsdbPortConfig(7) [lindex [stc::get $Port(7) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(7) \
        -CaCertificates {}

set VxlanPortConfig(7) [lindex [stc::get $Port(7) -children-VxlanPortConfig] 0]


set StpPortConfig(7) [lindex [stc::get $Port(7) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(7) [lindex [stc::get $Port(7) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(7) [lindex [stc::get $Port(7) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(7) [lindex [stc::get $Port(7) -children-SaaPortConfig] 0]


set L2tpPortConfig(7) [lindex [stc::get $Port(7) -children-L2tpPortConfig] 0]


set PppoxPortConfig(7) [lindex [stc::get $Port(7) -children-PppoxPortConfig] 0]


set PppProtocolConfig(7) [lindex [stc::get $Port(7) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(7) \
        -Protocol "PPPOPOS"

set AncpPortConfig(7) [lindex [stc::get $Port(7) -children-AncpPortConfig] 0]


set EoamPortConfig(7) [lindex [stc::get $Port(7) -children-EoamPortConfig] 0]


set AppPerfPortConfig(7) [lindex [stc::get $Port(7) -children-AppPerfPortConfig] 0]


set VqAnalyzer(7) [lindex [stc::get $Port(7) -children-VqAnalyzer] 0]


set EthernetCopper(13) [stc::create "EthernetCopper" \
        -under $Port(7) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(13) [lindex [stc::get $EthernetCopper(13) -children-Mii] 0]


set MiiRegister(385) [lindex [stc::get $Mii(13) -children-MiiRegister] 0]
stc::config $MiiRegister(385) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(386) [lindex [stc::get $Mii(13) -children-MiiRegister] 1]
stc::config $MiiRegister(386) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(387) [lindex [stc::get $Mii(13) -children-MiiRegister] 2]
stc::config $MiiRegister(387) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(388) [lindex [stc::get $Mii(13) -children-MiiRegister] 3]
stc::config $MiiRegister(388) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(389) [lindex [stc::get $Mii(13) -children-MiiRegister] 4]
stc::config $MiiRegister(389) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(390) [lindex [stc::get $Mii(13) -children-MiiRegister] 5]
stc::config $MiiRegister(390) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(391) [lindex [stc::get $Mii(13) -children-MiiRegister] 6]
stc::config $MiiRegister(391) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(392) [lindex [stc::get $Mii(13) -children-MiiRegister] 7]
stc::config $MiiRegister(392) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(393) [lindex [stc::get $Mii(13) -children-MiiRegister] 8]
stc::config $MiiRegister(393) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(394) [lindex [stc::get $Mii(13) -children-MiiRegister] 9]
stc::config $MiiRegister(394) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(395) [lindex [stc::get $Mii(13) -children-MiiRegister] 10]
stc::config $MiiRegister(395) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(396) [lindex [stc::get $Mii(13) -children-MiiRegister] 11]
stc::config $MiiRegister(396) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(397) [lindex [stc::get $Mii(13) -children-MiiRegister] 12]
stc::config $MiiRegister(397) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(398) [lindex [stc::get $Mii(13) -children-MiiRegister] 13]
stc::config $MiiRegister(398) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(399) [lindex [stc::get $Mii(13) -children-MiiRegister] 14]
stc::config $MiiRegister(399) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(400) [lindex [stc::get $Mii(13) -children-MiiRegister] 15]
stc::config $MiiRegister(400) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(401) [lindex [stc::get $Mii(13) -children-MiiRegister] 16]
stc::config $MiiRegister(401) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(402) [lindex [stc::get $Mii(13) -children-MiiRegister] 17]
stc::config $MiiRegister(402) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(403) [lindex [stc::get $Mii(13) -children-MiiRegister] 18]
stc::config $MiiRegister(403) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(404) [lindex [stc::get $Mii(13) -children-MiiRegister] 19]
stc::config $MiiRegister(404) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(405) [lindex [stc::get $Mii(13) -children-MiiRegister] 20]
stc::config $MiiRegister(405) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(406) [lindex [stc::get $Mii(13) -children-MiiRegister] 21]
stc::config $MiiRegister(406) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(407) [lindex [stc::get $Mii(13) -children-MiiRegister] 22]
stc::config $MiiRegister(407) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(408) [lindex [stc::get $Mii(13) -children-MiiRegister] 23]
stc::config $MiiRegister(408) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(409) [lindex [stc::get $Mii(13) -children-MiiRegister] 24]
stc::config $MiiRegister(409) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(410) [lindex [stc::get $Mii(13) -children-MiiRegister] 25]
stc::config $MiiRegister(410) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(411) [lindex [stc::get $Mii(13) -children-MiiRegister] 26]
stc::config $MiiRegister(411) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(412) [lindex [stc::get $Mii(13) -children-MiiRegister] 27]
stc::config $MiiRegister(412) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(413) [lindex [stc::get $Mii(13) -children-MiiRegister] 28]
stc::config $MiiRegister(413) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(414) [lindex [stc::get $Mii(13) -children-MiiRegister] 29]
stc::config $MiiRegister(414) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(415) [lindex [stc::get $Mii(13) -children-MiiRegister] 30]
stc::config $MiiRegister(415) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(416) [lindex [stc::get $Mii(13) -children-MiiRegister] 31]
stc::config $MiiRegister(416) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(14) [stc::create "EthernetCopper" \
        -under $Port(7) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(14) [lindex [stc::get $EthernetCopper(14) -children-Mii] 0]


set MiiRegister(417) [lindex [stc::get $Mii(14) -children-MiiRegister] 0]
stc::config $MiiRegister(417) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(418) [lindex [stc::get $Mii(14) -children-MiiRegister] 1]
stc::config $MiiRegister(418) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(419) [lindex [stc::get $Mii(14) -children-MiiRegister] 2]
stc::config $MiiRegister(419) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(420) [lindex [stc::get $Mii(14) -children-MiiRegister] 3]
stc::config $MiiRegister(420) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(421) [lindex [stc::get $Mii(14) -children-MiiRegister] 4]
stc::config $MiiRegister(421) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(422) [lindex [stc::get $Mii(14) -children-MiiRegister] 5]
stc::config $MiiRegister(422) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(423) [lindex [stc::get $Mii(14) -children-MiiRegister] 6]
stc::config $MiiRegister(423) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(424) [lindex [stc::get $Mii(14) -children-MiiRegister] 7]
stc::config $MiiRegister(424) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(425) [lindex [stc::get $Mii(14) -children-MiiRegister] 8]
stc::config $MiiRegister(425) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(426) [lindex [stc::get $Mii(14) -children-MiiRegister] 9]
stc::config $MiiRegister(426) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(427) [lindex [stc::get $Mii(14) -children-MiiRegister] 10]
stc::config $MiiRegister(427) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(428) [lindex [stc::get $Mii(14) -children-MiiRegister] 11]
stc::config $MiiRegister(428) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(429) [lindex [stc::get $Mii(14) -children-MiiRegister] 12]
stc::config $MiiRegister(429) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(430) [lindex [stc::get $Mii(14) -children-MiiRegister] 13]
stc::config $MiiRegister(430) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(431) [lindex [stc::get $Mii(14) -children-MiiRegister] 14]
stc::config $MiiRegister(431) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(432) [lindex [stc::get $Mii(14) -children-MiiRegister] 15]
stc::config $MiiRegister(432) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(433) [lindex [stc::get $Mii(14) -children-MiiRegister] 16]
stc::config $MiiRegister(433) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(434) [lindex [stc::get $Mii(14) -children-MiiRegister] 17]
stc::config $MiiRegister(434) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(435) [lindex [stc::get $Mii(14) -children-MiiRegister] 18]
stc::config $MiiRegister(435) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(436) [lindex [stc::get $Mii(14) -children-MiiRegister] 19]
stc::config $MiiRegister(436) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(437) [lindex [stc::get $Mii(14) -children-MiiRegister] 20]
stc::config $MiiRegister(437) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(438) [lindex [stc::get $Mii(14) -children-MiiRegister] 21]
stc::config $MiiRegister(438) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(439) [lindex [stc::get $Mii(14) -children-MiiRegister] 22]
stc::config $MiiRegister(439) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(440) [lindex [stc::get $Mii(14) -children-MiiRegister] 23]
stc::config $MiiRegister(440) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(441) [lindex [stc::get $Mii(14) -children-MiiRegister] 24]
stc::config $MiiRegister(441) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(442) [lindex [stc::get $Mii(14) -children-MiiRegister] 25]
stc::config $MiiRegister(442) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(443) [lindex [stc::get $Mii(14) -children-MiiRegister] 26]
stc::config $MiiRegister(443) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(444) [lindex [stc::get $Mii(14) -children-MiiRegister] 27]
stc::config $MiiRegister(444) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(445) [lindex [stc::get $Mii(14) -children-MiiRegister] 28]
stc::config $MiiRegister(445) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(446) [lindex [stc::get $Mii(14) -children-MiiRegister] 29]
stc::config $MiiRegister(446) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(447) [lindex [stc::get $Mii(14) -children-MiiRegister] 30]
stc::config $MiiRegister(447) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(448) [lindex [stc::get $Mii(14) -children-MiiRegister] 31]
stc::config $MiiRegister(448) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set Host(8) [lindex [stc::get $Port(8) -children-Host] 0]


set EthIIIf(8) [stc::create "EthIIIf" \
        -under $Host(8) \
        -SrcMacList "" ]

set HdlcIf(8) [stc::create "HdlcIf" \
        -under $Host(8) ]

set PppIf(15) [stc::create "PppIf" \
        -under $Host(8) ]

set PppIf(16) [stc::create "PppIf" \
        -under $Host(8) ]

set Ipv4If(8) [stc::create "Ipv4If" \
        -under $Host(8) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(15) [stc::create "Ipv6If" \
        -under $Host(8) \
        -AddrList "" \
        -GatewayList "" ]

set Ipv6If(16) [stc::create "Ipv6If" \
        -under $Host(8) \
        -AddrList "" \
        -GatewayList "" ]

set Generator(8) [lindex [stc::get $Port(8) -children-Generator] 0]


set GeneratorConfig(8) [lindex [stc::get $Generator(8) -children-GeneratorConfig] 0]


set Analyzer(8) [lindex [stc::get $Port(8) -children-Analyzer] 0]


set AnalyzerConfig(8) [lindex [stc::get $Analyzer(8) -children-AnalyzerConfig] 0]


set InterarrivalTimeHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(8) [lindex [stc::get $AnalyzerConfig(8) -children-JitterHistogram] 0]
stc::config $JitterHistogram(8) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(8) [lindex [stc::get $Analyzer(8) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(8) [lindex [stc::get $Analyzer(8) -children-HighResolutionSamplingPortConfig] 0]


set Capture(8) [lindex [stc::get $Port(8) -children-Capture] 0]


set CaptureFilter(8) [lindex [stc::get $Capture(8) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(8) [lindex [stc::get $Capture(8) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(8) [lindex [stc::get $Capture(8) -children-CaptureFilterStopEvent] 0]


set CaptureIeee80211(8) [lindex [stc::get $Capture(8) -children-CaptureIeee80211] 0]


set CaptureRawPacketTagsInfo(8) [lindex [stc::get $Capture(8) -children-CaptureRawPacketTagsInfo] 0]


set IgmpPortConfig(8) [lindex [stc::get $Port(8) -children-IgmpPortConfig] 0]


set MldPortConfig(8) [lindex [stc::get $Port(8) -children-MldPortConfig] 0]


set ArpCache(8) [lindex [stc::get $Port(8) -children-ArpCache] 0]


set ArpNdReport(8) [lindex [stc::get $Port(8) -children-ArpNdReport] 0]


set PingReport(8) [lindex [stc::get $Port(8) -children-PingReport] 0]


set OsePortConfig(8) [lindex [stc::get $Port(8) -children-OsePortConfig] 0]


set OvsdbPortConfig(8) [lindex [stc::get $Port(8) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(8) \
        -CaCertificates {}

set VxlanPortConfig(8) [lindex [stc::get $Port(8) -children-VxlanPortConfig] 0]


set StpPortConfig(8) [lindex [stc::get $Port(8) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(8) [lindex [stc::get $Port(8) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(8) [lindex [stc::get $Port(8) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(8) [lindex [stc::get $Port(8) -children-SaaPortConfig] 0]


set L2tpPortConfig(8) [lindex [stc::get $Port(8) -children-L2tpPortConfig] 0]


set PppoxPortConfig(8) [lindex [stc::get $Port(8) -children-PppoxPortConfig] 0]


set PppProtocolConfig(8) [lindex [stc::get $Port(8) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(8) \
        -Protocol "PPPOPOS"

set AncpPortConfig(8) [lindex [stc::get $Port(8) -children-AncpPortConfig] 0]


set EoamPortConfig(8) [lindex [stc::get $Port(8) -children-EoamPortConfig] 0]


set AppPerfPortConfig(8) [lindex [stc::get $Port(8) -children-AppPerfPortConfig] 0]


set VqAnalyzer(8) [lindex [stc::get $Port(8) -children-VqAnalyzer] 0]


set EthernetCopper(15) [stc::create "EthernetCopper" \
        -under $Port(8) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(15) [lindex [stc::get $EthernetCopper(15) -children-Mii] 0]


set MiiRegister(449) [lindex [stc::get $Mii(15) -children-MiiRegister] 0]
stc::config $MiiRegister(449) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(450) [lindex [stc::get $Mii(15) -children-MiiRegister] 1]
stc::config $MiiRegister(450) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(451) [lindex [stc::get $Mii(15) -children-MiiRegister] 2]
stc::config $MiiRegister(451) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(452) [lindex [stc::get $Mii(15) -children-MiiRegister] 3]
stc::config $MiiRegister(452) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(453) [lindex [stc::get $Mii(15) -children-MiiRegister] 4]
stc::config $MiiRegister(453) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(454) [lindex [stc::get $Mii(15) -children-MiiRegister] 5]
stc::config $MiiRegister(454) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(455) [lindex [stc::get $Mii(15) -children-MiiRegister] 6]
stc::config $MiiRegister(455) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(456) [lindex [stc::get $Mii(15) -children-MiiRegister] 7]
stc::config $MiiRegister(456) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(457) [lindex [stc::get $Mii(15) -children-MiiRegister] 8]
stc::config $MiiRegister(457) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(458) [lindex [stc::get $Mii(15) -children-MiiRegister] 9]
stc::config $MiiRegister(458) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(459) [lindex [stc::get $Mii(15) -children-MiiRegister] 10]
stc::config $MiiRegister(459) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(460) [lindex [stc::get $Mii(15) -children-MiiRegister] 11]
stc::config $MiiRegister(460) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(461) [lindex [stc::get $Mii(15) -children-MiiRegister] 12]
stc::config $MiiRegister(461) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(462) [lindex [stc::get $Mii(15) -children-MiiRegister] 13]
stc::config $MiiRegister(462) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(463) [lindex [stc::get $Mii(15) -children-MiiRegister] 14]
stc::config $MiiRegister(463) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(464) [lindex [stc::get $Mii(15) -children-MiiRegister] 15]
stc::config $MiiRegister(464) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(465) [lindex [stc::get $Mii(15) -children-MiiRegister] 16]
stc::config $MiiRegister(465) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(466) [lindex [stc::get $Mii(15) -children-MiiRegister] 17]
stc::config $MiiRegister(466) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(467) [lindex [stc::get $Mii(15) -children-MiiRegister] 18]
stc::config $MiiRegister(467) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(468) [lindex [stc::get $Mii(15) -children-MiiRegister] 19]
stc::config $MiiRegister(468) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(469) [lindex [stc::get $Mii(15) -children-MiiRegister] 20]
stc::config $MiiRegister(469) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(470) [lindex [stc::get $Mii(15) -children-MiiRegister] 21]
stc::config $MiiRegister(470) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(471) [lindex [stc::get $Mii(15) -children-MiiRegister] 22]
stc::config $MiiRegister(471) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(472) [lindex [stc::get $Mii(15) -children-MiiRegister] 23]
stc::config $MiiRegister(472) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(473) [lindex [stc::get $Mii(15) -children-MiiRegister] 24]
stc::config $MiiRegister(473) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(474) [lindex [stc::get $Mii(15) -children-MiiRegister] 25]
stc::config $MiiRegister(474) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(475) [lindex [stc::get $Mii(15) -children-MiiRegister] 26]
stc::config $MiiRegister(475) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(476) [lindex [stc::get $Mii(15) -children-MiiRegister] 27]
stc::config $MiiRegister(476) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(477) [lindex [stc::get $Mii(15) -children-MiiRegister] 28]
stc::config $MiiRegister(477) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(478) [lindex [stc::get $Mii(15) -children-MiiRegister] 29]
stc::config $MiiRegister(478) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(479) [lindex [stc::get $Mii(15) -children-MiiRegister] 30]
stc::config $MiiRegister(479) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(480) [lindex [stc::get $Mii(15) -children-MiiRegister] 31]
stc::config $MiiRegister(480) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set EthernetCopper(16) [stc::create "EthernetCopper" \
        -under $Port(8) \
        -AlternateSpeeds "" \
        -ManagementRegistersTemplate {Templates/Mii/default_mii.xml} ]

set Mii(16) [lindex [stc::get $EthernetCopper(16) -children-Mii] 0]


set MiiRegister(481) [lindex [stc::get $Mii(16) -children-MiiRegister] 0]
stc::config $MiiRegister(481) \
        -RegValue "4416" \
        -Name {Control}

set MiiRegister(482) [lindex [stc::get $Mii(16) -children-MiiRegister] 1]
stc::config $MiiRegister(482) \
        -Address "1" \
        -RegValue "31085" \
        -WritableMask "0" \
        -Name {Status}

set MiiRegister(483) [lindex [stc::get $Mii(16) -children-MiiRegister] 2]
stc::config $MiiRegister(483) \
        -Address "2" \
        -RegValue "32" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(484) [lindex [stc::get $Mii(16) -children-MiiRegister] 3]
stc::config $MiiRegister(484) \
        -Address "3" \
        -RegValue "24753" \
        -WritableMask "0" \
        -Name {PHY Identifier}

set MiiRegister(485) [lindex [stc::get $Mii(16) -children-MiiRegister] 4]
stc::config $MiiRegister(485) \
        -Address "4" \
        -RegValue "481" \
        -Name {Auto-Negotiation Advertisement}

set MiiRegister(486) [lindex [stc::get $Mii(16) -children-MiiRegister] 5]
stc::config $MiiRegister(486) \
        -Address "5" \
        -RegValue "19937" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Base Page Ability}

set MiiRegister(487) [lindex [stc::get $Mii(16) -children-MiiRegister] 6]
stc::config $MiiRegister(487) \
        -Address "6" \
        -RegValue "5" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Expansion}

set MiiRegister(488) [lindex [stc::get $Mii(16) -children-MiiRegister] 7]
stc::config $MiiRegister(488) \
        -Address "7" \
        -RegValue "8193" \
        -WritableMask "47103" \
        -Name {Auto-Negotiation Next Page Transmit}

set MiiRegister(489) [lindex [stc::get $Mii(16) -children-MiiRegister] 8]
stc::config $MiiRegister(489) \
        -Address "8" \
        -WritableMask "0" \
        -Name {Auto-Negotiation Link Partner Received Next Page}

set MiiRegister(490) [lindex [stc::get $Mii(16) -children-MiiRegister] 9]
stc::config $MiiRegister(490) \
        -Address "9" \
        -RegValue "512" \
        -Name {MASTER-SLAVE Control Register}

set MiiRegister(491) [lindex [stc::get $Mii(16) -children-MiiRegister] 10]
stc::config $MiiRegister(491) \
        -Address "10" \
        -WritableMask "0" \
        -Name {MASTER-SLAVE Status Register}

set MiiRegister(492) [lindex [stc::get $Mii(16) -children-MiiRegister] 11]
stc::config $MiiRegister(492) \
        -Address "11" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(493) [lindex [stc::get $Mii(16) -children-MiiRegister] 12]
stc::config $MiiRegister(493) \
        -Address "12" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(494) [lindex [stc::get $Mii(16) -children-MiiRegister] 13]
stc::config $MiiRegister(494) \
        -Address "13" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(495) [lindex [stc::get $Mii(16) -children-MiiRegister] 14]
stc::config $MiiRegister(495) \
        -Address "14" \
        -WritableMask "0" \
        -Name {Reserved}

set MiiRegister(496) [lindex [stc::get $Mii(16) -children-MiiRegister] 15]
stc::config $MiiRegister(496) \
        -Address "15" \
        -RegValue "12288" \
        -WritableMask "0" \
        -Name {Extended Status}

set MiiRegister(497) [lindex [stc::get $Mii(16) -children-MiiRegister] 16]
stc::config $MiiRegister(497) \
        -Address "16" \
        -RegValue "16385" \
        -Name {Vendor Specific}

set MiiRegister(498) [lindex [stc::get $Mii(16) -children-MiiRegister] 17]
stc::config $MiiRegister(498) \
        -Address "17" \
        -RegValue "768" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(499) [lindex [stc::get $Mii(16) -children-MiiRegister] 18]
stc::config $MiiRegister(499) \
        -Address "18" \
        -Name {Vendor Specific}

set MiiRegister(500) [lindex [stc::get $Mii(16) -children-MiiRegister] 19]
stc::config $MiiRegister(500) \
        -Address "19" \
        -Name {Vendor Specific}

set MiiRegister(501) [lindex [stc::get $Mii(16) -children-MiiRegister] 20]
stc::config $MiiRegister(501) \
        -Address "20" \
        -Name {Vendor Specific}

set MiiRegister(502) [lindex [stc::get $Mii(16) -children-MiiRegister] 21]
stc::config $MiiRegister(502) \
        -Address "21" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(503) [lindex [stc::get $Mii(16) -children-MiiRegister] 22]
stc::config $MiiRegister(503) \
        -Address "22" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(504) [lindex [stc::get $Mii(16) -children-MiiRegister] 23]
stc::config $MiiRegister(504) \
        -Address "23" \
        -Name {Vendor Specific}

set MiiRegister(505) [lindex [stc::get $Mii(16) -children-MiiRegister] 24]
stc::config $MiiRegister(505) \
        -Address "24" \
        -RegValue "25600" \
        -Name {Vendor Specific}

set MiiRegister(506) [lindex [stc::get $Mii(16) -children-MiiRegister] 25]
stc::config $MiiRegister(506) \
        -Address "25" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(507) [lindex [stc::get $Mii(16) -children-MiiRegister] 26]
stc::config $MiiRegister(507) \
        -Address "26" \
        -Name {Vendor Specific}

set MiiRegister(508) [lindex [stc::get $Mii(16) -children-MiiRegister] 27]
stc::config $MiiRegister(508) \
        -Address "27" \
        -RegValue "65535" \
        -Name {Vendor Specific}

set MiiRegister(509) [lindex [stc::get $Mii(16) -children-MiiRegister] 28]
stc::config $MiiRegister(509) \
        -Address "28" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(510) [lindex [stc::get $Mii(16) -children-MiiRegister] 29]
stc::config $MiiRegister(510) \
        -Address "29" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(511) [lindex [stc::get $Mii(16) -children-MiiRegister] 30]
stc::config $MiiRegister(511) \
        -Address "30" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set MiiRegister(512) [lindex [stc::get $Mii(16) -children-MiiRegister] 31]
stc::config $MiiRegister(512) \
        -Address "31" \
        -WritableMask "0" \
        -Name {Vendor Specific}

set AutomationOptions(1) [lindex [stc::get $system1 -children-AutomationOptions] 0]
stc::config $AutomationOptions(1) \
        -AutoSubscribe "FALSE"

set PhysicalChassisManager(1) [stc::create "PhysicalChassisManager" \
        -under $system1 ]

set Sequencer(1) [stc::create "Sequencer" \
        -under $system1 \
        -CurrentSubCommandName {Learning: Verify Ping Status 1} ]

set PingVerifyConnectivityCommand(1) [stc::create "PingVerifyConnectivityCommand" \
        -under $Sequencer(1) \
        -ErrorOnFailure "TRUE" \
        -Name {Learning: Verify Ping Status 1} ]

set SequencerGroupCommand(1) [stc::create "SequencerGroupCommand" \
        -under $system1 \
        -GroupCategory "CLEANUP_COMMAND" \
        -Name {Cleanup Commands} ]

set IfManager(1) [stc::create "IfManager" \
        -under $system1 ]

set LinkRegistry(1) [stc::create "LinkRegistry" \
        -under $system1 ]

set ActiveEventManager(1) [lindex [stc::get $system1 -children-ActiveEventManager] 0]


set FeatureSupportedVersion(1) [lindex [stc::get $system1 -children-FeatureSupportedVersion] 0]


# Set up relationships
stc::config $Project(1) -DefaultSelection-targets " $FrameLengthDistribution(1) "
stc::config $Port(1) -ActivePhy-targets " $EthernetCopper(2) "
stc::config $Port(2) -ActivePhy-targets " $EthernetCopper(4) "
stc::config $Port(3) -ActivePhy-targets " $EthernetCopper(6) "
stc::config $Port(4) -ActivePhy-targets " $EthernetCopper(8) "
stc::config $Port(5) -ActivePhy-targets " $EthernetCopper(10) "
stc::config $Port(6) -ActivePhy-targets " $EthernetCopper(12) "
stc::config $Port(7) -ActivePhy-targets " $EthernetCopper(14) "
stc::config $Port(8) -ActivePhy-targets " $EthernetCopper(16) "
stc::config $Tags(1) -DefaultTag-targets " $Tag(1) $Tag(2) $Tag(3) $Tag(4) $Tag(5) $Tag(6) "
stc::config $PerspectiveNode(1) -PerspectiveChild-targets " $ResultDataSet(1) $DynamicResultView(1) "
stc::config $PerspectiveNode(2) -PerspectiveChild-targets " $ResultDataSet(1) $DynamicResultView(1) "
stc::config $Host(1) -TopLevelIf-targets " $Ipv4If(1) $Ipv6If(1) $Ipv6If(2) "
stc::config $Ipv4If(1) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $Ipv6If(1) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $Ipv6If(2) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $AnalyzerConfig(1) -ActiveHistogram-targets " $LatencyHistogram(1) "
stc::config $Host(2) -TopLevelIf-targets " $Ipv4If(2) $Ipv6If(3) $Ipv6If(4) "
stc::config $Ipv4If(2) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $Ipv6If(3) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $Ipv6If(4) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $AnalyzerConfig(2) -ActiveHistogram-targets " $LatencyHistogram(2) "
stc::config $Host(3) -TopLevelIf-targets " $Ipv4If(3) $Ipv6If(5) $Ipv6If(6) "
stc::config $Ipv4If(3) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $Ipv6If(5) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $Ipv6If(6) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $AnalyzerConfig(3) -ActiveHistogram-targets " $LatencyHistogram(3) "
stc::config $Host(4) -TopLevelIf-targets " $Ipv4If(4) $Ipv6If(7) $Ipv6If(8) "
stc::config $Ipv4If(4) -StackedOnEndpoint-targets " $EthIIIf(4) "
stc::config $Ipv6If(7) -StackedOnEndpoint-targets " $EthIIIf(4) "
stc::config $Ipv6If(8) -StackedOnEndpoint-targets " $EthIIIf(4) "
stc::config $AnalyzerConfig(4) -ActiveHistogram-targets " $LatencyHistogram(4) "
stc::config $Host(5) -TopLevelIf-targets " $Ipv4If(5) $Ipv6If(9) $Ipv6If(10) "
stc::config $Ipv4If(5) -StackedOnEndpoint-targets " $EthIIIf(5) "
stc::config $Ipv6If(9) -StackedOnEndpoint-targets " $EthIIIf(5) "
stc::config $Ipv6If(10) -StackedOnEndpoint-targets " $EthIIIf(5) "
stc::config $AnalyzerConfig(5) -ActiveHistogram-targets " $LatencyHistogram(5) "
stc::config $Host(6) -TopLevelIf-targets " $Ipv4If(6) $Ipv6If(11) $Ipv6If(12) "
stc::config $Ipv4If(6) -StackedOnEndpoint-targets " $EthIIIf(6) "
stc::config $Ipv6If(11) -StackedOnEndpoint-targets " $EthIIIf(6) "
stc::config $Ipv6If(12) -StackedOnEndpoint-targets " $EthIIIf(6) "
stc::config $AnalyzerConfig(6) -ActiveHistogram-targets " $LatencyHistogram(6) "
stc::config $Host(7) -TopLevelIf-targets " $Ipv4If(7) $Ipv6If(13) $Ipv6If(14) "
stc::config $Ipv4If(7) -StackedOnEndpoint-targets " $EthIIIf(7) "
stc::config $Ipv6If(13) -StackedOnEndpoint-targets " $EthIIIf(7) "
stc::config $Ipv6If(14) -StackedOnEndpoint-targets " $EthIIIf(7) "
stc::config $AnalyzerConfig(7) -ActiveHistogram-targets " $LatencyHistogram(7) "
stc::config $Host(8) -TopLevelIf-targets " $Ipv4If(8) $Ipv6If(15) $Ipv6If(16) "
stc::config $Ipv4If(8) -StackedOnEndpoint-targets " $EthIIIf(8) "
stc::config $Ipv6If(15) -StackedOnEndpoint-targets " $EthIIIf(8) "
stc::config $Ipv6If(16) -StackedOnEndpoint-targets " $EthIIIf(8) "
stc::config $AnalyzerConfig(8) -ActiveHistogram-targets " $LatencyHistogram(8) "
stc::config $Sequencer(1) -SequencerFinalizeType-targets " $SequencerGroupCommand(1) "

# Set up handles
stc::config $SequencerGroupCommand(1) -CommandList ""
stc::config $Sequencer(1) -CommandList "$PingVerifyConnectivityCommand(1)"
stc::config $Sequencer(1) -BreakpointList ""
stc::config $Sequencer(1) -DisabledCommandList ""
stc::config $Sequencer(1) -CleanupCommand "$SequencerGroupCommand(1)"
stc::config $ResultQuery(2) -ResultRootList "$Project(1)"
stc::config $ResultQuery(2) -PropertyHandleArray ""
stc::config $ResultQuery(1) -ResultRootList "$Project(1)"
stc::config $ResultQuery(1) -PropertyHandleArray ""
stc::config $PresentationResultQuery(1) -FromObjects "$Project(1)"
stc::config $PingVerifyConnectivityCommand(1) -DeviceList "$Port(1) $Port(2) $Port(3) $Port(4) $Port(5) $Port(6) $Port(7) $Port(8)"

stc::config system1 -IsLoadingFromConfiguration "false"

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
    # Subscribe to results for result query ping-0001-generatorportresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType generator \
        -resultType generatorportresults \
        -filterList "" \
        -viewAttributeList "totalframecount totaloctetcount generatorframecount generatoroctetcount generatorsigframecount generatorundersizeframecount generatoroversizeframecount generatorjumboframecount totalframerate totaloctetrate generatorframerate generatoroctetrate generatorsigframerate generatorundersizeframerate generatoroversizeframerate generatorjumboframerate generatorcrcerrorframecount generatorl3checksumerrorcount generatorl4checksumerrorcount generatorcrcerrorframerate generatorl3checksumerrorrate generatorl4checksumerrorrate totalipv4framecount totalipv6framecount totalmplsframecount generatoripv4framecount generatoripv6framecount generatorvlanframecount generatormplsframecount totalipv4framerate totalipv6framerate totalmplsframerate generatoripv4framerate generatoripv6framerate generatorvlanframerate generatormplsframerate totalbitrate generatorbitrate l1bitcount l1bitrate pfcframecount pfcpri0framecount pfcpri1framecount pfcpri2framecount pfcpri3framecount pfcpri4framecount pfcpri5framecount pfcpri6framecount pfcpri7framecount l1bitratepercent " \
        -interval 1 -filenamePrefix "ping-0001-generatorportresults"

    # Subscribe to results for result query ping-0002-analyzerportresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType analyzer \
        -resultType analyzerportresults \
        -filterList "" \
        -viewAttributeList "totalframecount totaloctetcount sigframecount undersizeframecount oversizeframecount jumboframecount minframelength maxframelength pauseframecount totalframerate totaloctetrate sigframerate undersizeframerate oversizeframerate jumboframerate pauseframerate fcserrorframecount ipv4checksumerrorcount tcpchecksumerrorcount udpchecksumerrorcount prbsfilloctetcount prbsbiterrorcount fcserrorframerate ipv4checksumerrorrate tcpchecksumerrorrate udpchecksumerrorrate prbsfilloctetrate prbsbiterrorrate ipv4framecount ipv6framecount ipv6overipv4framecount tcpframecount udpframecount mplsframecount icmpframecount vlanframecount ipv4framerate ipv6framerate ipv6overipv4framerate tcpframerate udpframerate mplsframerate icmpframerate vlanframerate trigger1count trigger1rate trigger2count trigger2rate trigger3count trigger3rate trigger4count trigger4rate trigger5count trigger5rate trigger6count trigger6rate trigger7count trigger7rate trigger8count trigger8rate combotriggercount combotriggerrate totalbitrate prbsbiterrorratio vlanframerate l1bitcount l1bitrate pfcframecount fcoeframecount pfcframerate fcoeframerate pfcpri0framecount pfcpri1framecount pfcpri2framecount pfcpri3framecount pfcpri4framecount pfcpri5framecount pfcpri6framecount pfcpri7framecount pfcpri0quanta pfcpri1quanta pfcpri2quanta pfcpri3quanta pfcpri4quanta pfcpri5quanta pfcpri6quanta pfcpri7quanta prbserrorframecount prbserrorframerate userdefinedframecount1 userdefinedframerate1 userdefinedframecount2 userdefinedframerate2 userdefinedframecount3 userdefinedframerate3 userdefinedframecount4 userdefinedframerate4 userdefinedframecount5 userdefinedframerate5 userdefinedframecount6 userdefinedframerate6 l1bitratepercent outseqframecount preambletotalbytes preambleminlength preamblemaxlength droppedframecount inorderframecount reorderedframecount duplicateframecount lateframecount firstarrivaltime lastarrivaltime " \
        -interval 1 -filenamePrefix "ping-0002-analyzerportresults"

    # Start the sequencer
    stc::perform sequencerStart

    # Wait for sequencer to finish
    stc::waituntilcomplete

    # check the sequencer status and test state
    set sqrHandle [stc::get System1 -Children-Sequencer]
    set sqrStatus [stc::get $sqrHandle -Status]
    set sqrTestState [stc::get $sqrHandle -TestState]
    if { $sqrStatus eq "" }  {
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