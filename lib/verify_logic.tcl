# Spirent TestCenter Logic Script
# Generated on Tue Jan 02 13:56:42 2024 by NTtest
# Framework ver. 4.70.9706.0000
#
# Comments: 
# 
#
# This logic script contains the following routines invoked from the
# verify.tcl script.

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
        -SelectedTechnologyProfiles {stp} \
        -ConfigurationFileName {verify.tcl} ]

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

set ExposedConfig(1) [stc::create "ExposedConfig" \
        -under $Project(1) ]



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

set AutomationOptions(1) [lindex [stc::get $system1 -children-AutomationOptions] 0]
stc::config $AutomationOptions(1) \
        -AutoSubscribe "FALSE"

set PhysicalChassisManager(1) [stc::create "PhysicalChassisManager" \
        -under $system1 ]

set Sequencer(1) [stc::create "Sequencer" \
        -under $system1 \
        -CurrentSubCommandName {Verify Link Status 1} ]

set PhyVerifyLinkUpCommand(1) [stc::create "PhyVerifyLinkUpCommand" \
        -under $Sequencer(1) \
        -ErrorOnFailure "TRUE" ]

set IfManager(1) [stc::create "IfManager" \
        -under $system1 ]

set LinkRegistry(1) [stc::create "LinkRegistry" \
        -under $system1 ]

set ActiveEventManager(1) [lindex [stc::get $system1 -children-ActiveEventManager] 0]


set FeatureSupportedVersion(1) [lindex [stc::get $system1 -children-FeatureSupportedVersion] 0]


set SequencerGroupCommand(1) [stc::create "SequencerGroupCommand" \
        -under $system1 \
        -GroupCategory "CLEANUP_COMMAND" \
        -Name {Cleanup Commands} ]

# Set up relationships
stc::config $Project(1) -DefaultSelection-targets " $FrameLengthDistribution(1) "
stc::config $Port(1) -ActivePhy-targets " $EthernetCopper(2) "
stc::config $Port(2) -ActivePhy-targets " $EthernetCopper(4) "
stc::config $Port(3) -ActivePhy-targets " $EthernetCopper(6) "
stc::config $Port(4) -ActivePhy-targets " $EthernetCopper(8) "
stc::config $Port(5) -ActivePhy-targets " $EthernetCopper(10) "
stc::config $Port(6) -ActivePhy-targets " $EthernetCopper(12) "
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
stc::config $Sequencer(1) -SequencerFinalizeType-targets " $SequencerGroupCommand(1) "

# Set up handles
stc::config $ResultQuery(1) -ResultRootList "$Project(1)"
stc::config $ResultQuery(1) -PropertyHandleArray ""
stc::config $ResultQuery(2) -ResultRootList "$Project(1)"
stc::config $ResultQuery(2) -PropertyHandleArray ""
stc::config $PresentationResultQuery(1) -FromObjects "$Project(1)"
stc::config $PhyVerifyLinkUpCommand(1) -PortList "$Port(1)"
stc::config $Sequencer(1) -CommandList "$PhyVerifyLinkUpCommand(1)"
stc::config $Sequencer(1) -BreakpointList ""
stc::config $Sequencer(1) -DisabledCommandList ""
stc::config $Sequencer(1) -CleanupCommand "$SequencerGroupCommand(1)"
stc::config $SequencerGroupCommand(1) -CommandList ""

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
    # Subscribe to results for result query verify-0001-generatorportresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType generator \
        -resultType generatorportresults \
        -filterList "" \
        -viewAttributeList "totalframecount totaloctetcount generatorframecount generatoroctetcount generatorsigframecount generatorundersizeframecount generatoroversizeframecount generatorjumboframecount totalframerate totaloctetrate generatorframerate generatoroctetrate generatorsigframerate generatorundersizeframerate generatoroversizeframerate generatorjumboframerate generatorcrcerrorframecount generatorl3checksumerrorcount generatorl4checksumerrorcount generatorcrcerrorframerate generatorl3checksumerrorrate generatorl4checksumerrorrate totalipv4framecount totalipv6framecount totalmplsframecount generatoripv4framecount generatoripv6framecount generatorvlanframecount generatormplsframecount totalipv4framerate totalipv6framerate totalmplsframerate generatoripv4framerate generatoripv6framerate generatorvlanframerate generatormplsframerate totalbitrate generatorbitrate l1bitcount l1bitrate pfcframecount pfcpri0framecount pfcpri1framecount pfcpri2framecount pfcpri3framecount pfcpri4framecount pfcpri5framecount pfcpri6framecount pfcpri7framecount l1bitratepercent " \
        -interval 1 -filenamePrefix "verify-0001-generatorportresults"

    # Subscribe to results for result query verify-0002-analyzerportresults
    stc::subscribe -parent [lindex [stc::get system1 -children-Project] 0] \
        -resultParent " [lindex [stc::get system1 -children-Project] 0] " \
        -configType analyzer \
        -resultType analyzerportresults \
        -filterList "" \
        -viewAttributeList "totalframecount totaloctetcount sigframecount undersizeframecount oversizeframecount jumboframecount minframelength maxframelength pauseframecount totalframerate totaloctetrate sigframerate undersizeframerate oversizeframerate jumboframerate pauseframerate fcserrorframecount ipv4checksumerrorcount tcpchecksumerrorcount udpchecksumerrorcount prbsfilloctetcount prbsbiterrorcount fcserrorframerate ipv4checksumerrorrate tcpchecksumerrorrate udpchecksumerrorrate prbsfilloctetrate prbsbiterrorrate ipv4framecount ipv6framecount ipv6overipv4framecount tcpframecount udpframecount mplsframecount icmpframecount vlanframecount ipv4framerate ipv6framerate ipv6overipv4framerate tcpframerate udpframerate mplsframerate icmpframerate vlanframerate trigger1count trigger1rate trigger2count trigger2rate trigger3count trigger3rate trigger4count trigger4rate trigger5count trigger5rate trigger6count trigger6rate trigger7count trigger7rate trigger8count trigger8rate combotriggercount combotriggerrate totalbitrate prbsbiterrorratio vlanframerate l1bitcount l1bitrate pfcframecount fcoeframecount pfcframerate fcoeframerate pfcpri0framecount pfcpri1framecount pfcpri2framecount pfcpri3framecount pfcpri4framecount pfcpri5framecount pfcpri6framecount pfcpri7framecount pfcpri0quanta pfcpri1quanta pfcpri2quanta pfcpri3quanta pfcpri4quanta pfcpri5quanta pfcpri6quanta pfcpri7quanta prbserrorframecount prbserrorframerate userdefinedframecount1 userdefinedframerate1 userdefinedframecount2 userdefinedframerate2 userdefinedframecount3 userdefinedframerate3 userdefinedframecount4 userdefinedframerate4 userdefinedframecount5 userdefinedframerate5 userdefinedframecount6 userdefinedframerate6 l1bitratepercent outseqframecount preambletotalbytes preambleminlength preamblemaxlength droppedframecount inorderframecount reorderedframecount duplicateframecount lateframecount firstarrivaltime lastarrivaltime " \
        -interval 1 -filenamePrefix "verify-0002-analyzerportresults"

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