# Spirent TestCenter Logic Script
# Generated on Tue Apr 16 10:12:13 2024 by NTtest
# Framework ver. 4.70.9706.0000
#
# Comments: 
# 
#
# This logic script contains the following routines invoked from the
# 3Port_1000M_Burst.tcl script.

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
        -ConfigurationFileName {3Port_1000M_Burst.tcl} ]

set Port(1) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 0] \
        -PortGroupSize "2" \
        -Name {Port //3/1 (offline)} ]

set Port(2) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 1] \
        -PortGroupSize "2" \
        -Name {Port //3/2 (offline)} ]

set Port(3) [stc::create "Port" \
        -under $Project(1) \
        -Location [lindex $portLocations 2] \
        -PortGroupSize "2" \
        -Name {Port //3/3 (offline)} ]

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

set FrameLengthDistribution(1) [stc::create "FrameLengthDistribution" \
        -under $Project(1) \
        -Name {Default} ]

set FrameLengthDistributionSlot(1) [lindex [stc::get $FrameLengthDistribution(1) -children-FrameLengthDistributionSlot] 0]
stc::config $FrameLengthDistributionSlot(1) \
        -FixedFrameLength "40" \
        -MinFrameLength "39" \
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
        -MinFrameLength "39" \
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
        -MinFrameLength "39" \
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

set DeviceAddrOptions(1) [lindex [stc::get $Project(1) -children-DeviceAddrOptions] 0]
stc::config $DeviceAddrOptions(1) \
        -NextIpv4 "192.85.6.3" \
        -NextMac "00:10:94:00:00:07" \
        -NextRouterId "192.0.5.1"

set PhyOptions(1) [lindex [stc::get $Project(1) -children-PhyOptions] 0]


set TestResultSetting(1) [lindex [stc::get $Project(1) -children-TestResultSetting] 0]


set TrafficOptions(1) [lindex [stc::get $Project(1) -children-TrafficOptions] 0]


set ResultOptions(1) [lindex [stc::get $Project(1) -children-ResultOptions] 0]
stc::config $ResultOptions(1) \
        -SaveAtEotProperties {}

set LabelBindingGlobalConfig(1) [lindex [stc::get $Project(1) -children-LabelBindingGlobalConfig] 0]


set BgpGlobalConfig(1) [lindex [stc::get $Project(1) -children-BgpGlobalConfig] 0]


set BgpSrGlobalConfig(1) [lindex [stc::get $BgpGlobalConfig(1) -children-BgpSrGlobalConfig] 0]


set BgpSrGlobalBlock(1) [lindex [stc::get $BgpSrGlobalConfig(1) -children-BgpSrGlobalBlock] 0]


set PimGlobalConfig(1) [lindex [stc::get $Project(1) -children-PimGlobalConfig] 0]


set IsisPlsbGlobalConfig(1) [lindex [stc::get $Project(1) -children-IsisPlsbGlobalConfig] 0]


set L2LearningConfig(1) [lindex [stc::get $Project(1) -children-L2LearningConfig] 0]


set ArpNdConfig(1) [lindex [stc::get $Project(1) -children-ArpNdConfig] 0]


set Dhcpv4Options(1) [lindex [stc::get $Project(1) -children-Dhcpv4Options] 0]


set Dhcpv6Options(1) [lindex [stc::get $Project(1) -children-Dhcpv6Options] 0]


set PppoxOptions(1) [lindex [stc::get $Project(1) -children-PppoxOptions] 0]


set EoamGlobalConfig(1) [lindex [stc::get $Project(1) -children-EoamGlobalConfig] 0]


set VqAnalyzerOptions(1) [lindex [stc::get $Project(1) -children-VqAnalyzerOptions] 0]


set ExternalDeviceOption(1) [lindex [stc::get $Project(1) -children-ExternalDeviceOption] 0]


set Dot1xOptions(1) [lindex [stc::get $Project(1) -children-Dot1xOptions] 0]


set VicGlobalConfig(1) [lindex [stc::get $Project(1) -children-VicGlobalConfig] 0]


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
stc::config $GeneratorConfig(1) \
        -Duration "500000" \
        -DurationMode "BURSTS" \
        -LoadUnit "MEGABITS_PER_SECOND" \
        -FixedLoad "950"

set Analyzer(1) [lindex [stc::get $Port(1) -children-Analyzer] 0]


set AnalyzerConfig(1) [lindex [stc::get $Analyzer(1) -children-AnalyzerConfig] 0]
stc::config $AnalyzerConfig(1) \
        -Name {Advanced Settings 1}

set InterarrivalTimeHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(1) [lindex [stc::get $AnalyzerConfig(1) -children-JitterHistogram] 0]
stc::config $JitterHistogram(1) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(1) [lindex [stc::get $Analyzer(1) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(1) [lindex [stc::get $Analyzer(1) -children-HighResolutionSamplingPortConfig] 0]


set Capture(1) [lindex [stc::get $Port(1) -children-Capture] 0]


set CaptureFilter(1) [lindex [stc::get $Capture(1) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(1) [lindex [stc::get $Capture(1) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(1) [lindex [stc::get $Capture(1) -children-CaptureFilterStopEvent] 0]


set CaptureRawPacketTagsInfo(1) [lindex [stc::get $Capture(1) -children-CaptureRawPacketTagsInfo] 0]


set CaptureIeee80211(1) [lindex [stc::get $Capture(1) -children-CaptureIeee80211] 0]


set IgmpPortConfig(1) [lindex [stc::get $Port(1) -children-IgmpPortConfig] 0]


set MldPortConfig(1) [lindex [stc::get $Port(1) -children-MldPortConfig] 0]


set ArpCache(1) [lindex [stc::get $Port(1) -children-ArpCache] 0]


set ArpNdReport(1) [lindex [stc::get $Port(1) -children-ArpNdReport] 0]


set PingReport(1) [lindex [stc::get $Port(1) -children-PingReport] 0]


set StpPortConfig(1) [lindex [stc::get $Port(1) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(1) [lindex [stc::get $Port(1) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(1) [lindex [stc::get $Port(1) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(1) [lindex [stc::get $Port(1) -children-SaaPortConfig] 0]


set L2tpPortConfig(1) [lindex [stc::get $Port(1) -children-L2tpPortConfig] 0]


set PppoxPortConfig(1) [lindex [stc::get $Port(1) -children-PppoxPortConfig] 0]


set PppProtocolConfig(1) [lindex [stc::get $Port(1) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(1) \
        -Protocol "PPPOPOS" \
        -MaxEchoRequestAttempts "0"

set AncpPortConfig(1) [lindex [stc::get $Port(1) -children-AncpPortConfig] 0]


set EoamPortConfig(1) [lindex [stc::get $Port(1) -children-EoamPortConfig] 0]
stc::config $EoamPortConfig(1) \
        -EchoTlvsInDelayMeasurementResponse "FALSE" \
        -EchoTlvsInLossMeasurementResponse "FALSE"

set VqAnalyzer(1) [lindex [stc::get $Port(1) -children-VqAnalyzer] 0]


set EthernetCopper(1) [stc::create "EthernetCopper" \
        -under $Port(1) \
        -AlternateSpeeds "" ]

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

set StreamBlock(1) [stc::create "StreamBlock" \
        -under $Port(1) \
        -EqualRxPortDistribution "FALSE" \
        -FixedFrameLength "64" \
        -Filter {Device,MPLS-TP,Bfd,Rip,Lldp,Ieee1588v2,Bgp,Isis,Ldp,Stp,Ospfv3,Lacp,Pim,Rsvp,Ospfv2,FCoE,FCPlugin,FCoEVFPort,FCFPort,TwampClient,TwampServer,LspPing,Lisp,Ancp,PppProtocol,PppoeProtocol,802.1x,Vepa,Packet Channel,SyncE,Dhcpv4,Dhcpv6,Cifs,Dpg,Http,Sip,Ftp,Video,XMPPvJ,RawTcp,CSMP,EthernetII} \
        -FrameConfig {<frame><config><pdus><pdu name="ethernet_13775" pdu="ethernet:EthernetII"><preamble minByteLength="4" >55555555555555d5</preamble><dstMac>00:10:94:00:00:02</dstMac><srcMac>00:10:94:00:00:01</srcMac></pdu></pdus></config></frame>} \
        -Name {StreamBlock 79-1-1} ]

set OsePortConfig(1) [lindex [stc::get $Port(1) -children-OsePortConfig] 0]


set OvsdbPortConfig(1) [lindex [stc::get $Port(1) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(1) \
        -CaCertificates {}

set VxlanPortConfig(1) [lindex [stc::get $Port(1) -children-VxlanPortConfig] 0]


set AppPerfPortConfig(1) [lindex [stc::get $Port(1) -children-AppPerfPortConfig] 0]


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
stc::config $GeneratorConfig(2) \
        -Duration "500000" \
        -DurationMode "BURSTS" \
        -LoadUnit "MEGABITS_PER_SECOND" \
        -FixedLoad "950"

set Analyzer(2) [lindex [stc::get $Port(2) -children-Analyzer] 0]


set AnalyzerConfig(2) [lindex [stc::get $Analyzer(2) -children-AnalyzerConfig] 0]
stc::config $AnalyzerConfig(2) \
        -Name {Advanced Settings 2}

set InterarrivalTimeHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(2) [lindex [stc::get $AnalyzerConfig(2) -children-JitterHistogram] 0]
stc::config $JitterHistogram(2) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(2) [lindex [stc::get $Analyzer(2) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(2) [lindex [stc::get $Analyzer(2) -children-HighResolutionSamplingPortConfig] 0]


set Capture(2) [lindex [stc::get $Port(2) -children-Capture] 0]


set CaptureFilter(2) [lindex [stc::get $Capture(2) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(2) [lindex [stc::get $Capture(2) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(2) [lindex [stc::get $Capture(2) -children-CaptureFilterStopEvent] 0]


set CaptureRawPacketTagsInfo(2) [lindex [stc::get $Capture(2) -children-CaptureRawPacketTagsInfo] 0]


set CaptureIeee80211(2) [lindex [stc::get $Capture(2) -children-CaptureIeee80211] 0]


set IgmpPortConfig(2) [lindex [stc::get $Port(2) -children-IgmpPortConfig] 0]


set MldPortConfig(2) [lindex [stc::get $Port(2) -children-MldPortConfig] 0]


set ArpCache(2) [lindex [stc::get $Port(2) -children-ArpCache] 0]


set ArpNdReport(2) [lindex [stc::get $Port(2) -children-ArpNdReport] 0]


set PingReport(2) [lindex [stc::get $Port(2) -children-PingReport] 0]


set StpPortConfig(2) [lindex [stc::get $Port(2) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(2) [lindex [stc::get $Port(2) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(2) [lindex [stc::get $Port(2) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(2) [lindex [stc::get $Port(2) -children-SaaPortConfig] 0]


set L2tpPortConfig(2) [lindex [stc::get $Port(2) -children-L2tpPortConfig] 0]


set PppoxPortConfig(2) [lindex [stc::get $Port(2) -children-PppoxPortConfig] 0]


set PppProtocolConfig(2) [lindex [stc::get $Port(2) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(2) \
        -Protocol "PPPOPOS" \
        -MaxEchoRequestAttempts "0"

set AncpPortConfig(2) [lindex [stc::get $Port(2) -children-AncpPortConfig] 0]


set EoamPortConfig(2) [lindex [stc::get $Port(2) -children-EoamPortConfig] 0]
stc::config $EoamPortConfig(2) \
        -EchoTlvsInDelayMeasurementResponse "FALSE" \
        -EchoTlvsInLossMeasurementResponse "FALSE"

set VqAnalyzer(2) [lindex [stc::get $Port(2) -children-VqAnalyzer] 0]


set EthernetCopper(2) [stc::create "EthernetCopper" \
        -under $Port(2) \
        -AlternateSpeeds "" ]

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

set StreamBlock(2) [stc::create "StreamBlock" \
        -under $Port(2) \
        -EqualRxPortDistribution "FALSE" \
        -FixedFrameLength "64" \
        -Filter {Device,MPLS-TP,Bfd,Rip,Lldp,Ieee1588v2,Bgp,Isis,Ldp,Stp,Ospfv3,Lacp,Pim,Rsvp,Ospfv2,FCoE,FCPlugin,FCoEVFPort,FCFPort,TwampClient,TwampServer,LspPing,Lisp,Ancp,PppProtocol,PppoeProtocol,802.1x,Vepa,Packet Channel,SyncE,Dhcpv4,Dhcpv6,Cifs,Dpg,Http,Sip,Ftp,Video,XMPPvJ,RawTcp,CSMP,EthernetII} \
        -FrameConfig {<frame><config><pdus><pdu name="ethernet_13775" pdu="ethernet:EthernetII"><preamble minByteLength="4" >55555555555555d5</preamble><dstMac>00:10:94:00:00:03</dstMac><srcMac>00:10:94:00:00:02</srcMac></pdu></pdus></config></frame>} \
        -Name {StreamBlock 79-2-1} ]

set OsePortConfig(2) [lindex [stc::get $Port(2) -children-OsePortConfig] 0]


set OvsdbPortConfig(2) [lindex [stc::get $Port(2) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(2) \
        -CaCertificates {}

set VxlanPortConfig(2) [lindex [stc::get $Port(2) -children-VxlanPortConfig] 0]


set AppPerfPortConfig(2) [lindex [stc::get $Port(2) -children-AppPerfPortConfig] 0]


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
stc::config $GeneratorConfig(3) \
        -Duration "500000" \
        -DurationMode "BURSTS" \
        -LoadUnit "MEGABITS_PER_SECOND" \
        -FixedLoad "950"

set Analyzer(3) [lindex [stc::get $Port(3) -children-Analyzer] 0]


set AnalyzerConfig(3) [lindex [stc::get $Analyzer(3) -children-AnalyzerConfig] 0]
stc::config $AnalyzerConfig(3) \
        -Name {Advanced Settings 3}

set InterarrivalTimeHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-InterarrivalTimeHistogram] 0]
stc::config $InterarrivalTimeHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set LatencyHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-LatencyHistogram] 0]
stc::config $LatencyHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set FrameLengthHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-FrameLengthHistogram] 0]
stc::config $FrameLengthHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqRunLengthHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-SeqRunLengthHistogram] 0]
stc::config $SeqRunLengthHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set SeqDiffCheckHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-SeqDiffCheckHistogram] 0]
stc::config $SeqDiffCheckHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set JitterHistogram(3) [lindex [stc::get $AnalyzerConfig(3) -children-JitterHistogram] 0]
stc::config $JitterHistogram(3) \
        -BucketSizeList "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 4294901761" \
        -LimitList "2 6 14 30 62 126 254 510 1022 2046 4094 8190 16382 32766 65534"

set DiffServConfig(3) [lindex [stc::get $Analyzer(3) -children-DiffServConfig] 0]


set HighResolutionSamplingPortConfig(3) [lindex [stc::get $Analyzer(3) -children-HighResolutionSamplingPortConfig] 0]


set Capture(3) [lindex [stc::get $Port(3) -children-Capture] 0]


set CaptureFilter(3) [lindex [stc::get $Capture(3) -children-CaptureFilter] 0]


set CaptureFilterStartEvent(3) [lindex [stc::get $Capture(3) -children-CaptureFilterStartEvent] 0]


set CaptureFilterStopEvent(3) [lindex [stc::get $Capture(3) -children-CaptureFilterStopEvent] 0]


set CaptureRawPacketTagsInfo(3) [lindex [stc::get $Capture(3) -children-CaptureRawPacketTagsInfo] 0]


set CaptureIeee80211(3) [lindex [stc::get $Capture(3) -children-CaptureIeee80211] 0]


set IgmpPortConfig(3) [lindex [stc::get $Port(3) -children-IgmpPortConfig] 0]


set MldPortConfig(3) [lindex [stc::get $Port(3) -children-MldPortConfig] 0]


set ArpCache(3) [lindex [stc::get $Port(3) -children-ArpCache] 0]


set ArpNdReport(3) [lindex [stc::get $Port(3) -children-ArpNdReport] 0]


set PingReport(3) [lindex [stc::get $Port(3) -children-PingReport] 0]


set StpPortConfig(3) [lindex [stc::get $Port(3) -children-StpPortConfig] 0]


set Dhcpv4PortConfig(3) [lindex [stc::get $Port(3) -children-Dhcpv4PortConfig] 0]


set Dhcpv6PortConfig(3) [lindex [stc::get $Port(3) -children-Dhcpv6PortConfig] 0]


set SaaPortConfig(3) [lindex [stc::get $Port(3) -children-SaaPortConfig] 0]


set L2tpPortConfig(3) [lindex [stc::get $Port(3) -children-L2tpPortConfig] 0]


set PppoxPortConfig(3) [lindex [stc::get $Port(3) -children-PppoxPortConfig] 0]


set PppProtocolConfig(3) [lindex [stc::get $Port(3) -children-PppProtocolConfig] 0]
stc::config $PppProtocolConfig(3) \
        -Protocol "PPPOPOS" \
        -MaxEchoRequestAttempts "0"

set AncpPortConfig(3) [lindex [stc::get $Port(3) -children-AncpPortConfig] 0]


set EoamPortConfig(3) [lindex [stc::get $Port(3) -children-EoamPortConfig] 0]
stc::config $EoamPortConfig(3) \
        -EchoTlvsInDelayMeasurementResponse "FALSE" \
        -EchoTlvsInLossMeasurementResponse "FALSE"

set VqAnalyzer(3) [lindex [stc::get $Port(3) -children-VqAnalyzer] 0]


set EthernetCopper(3) [stc::create "EthernetCopper" \
        -under $Port(3) \
        -AlternateSpeeds "" ]

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

set StreamBlock(3) [stc::create "StreamBlock" \
        -under $Port(3) \
        -EqualRxPortDistribution "FALSE" \
        -FixedFrameLength "64" \
        -Filter {Device,MPLS-TP,Bfd,Rip,Lldp,Ieee1588v2,Bgp,Isis,Ldp,Stp,Ospfv3,Lacp,Pim,Rsvp,Ospfv2,FCoE,FCPlugin,FCoEVFPort,FCFPort,TwampClient,TwampServer,LspPing,Lisp,Ancp,PppProtocol,PppoeProtocol,802.1x,Vepa,Packet Channel,SyncE,Dhcpv4,Dhcpv6,Cifs,Dpg,Http,Sip,Ftp,Video,XMPPvJ,RawTcp,CSMP,EthernetII} \
        -FrameConfig {<frame><config><pdus><pdu name="ethernet_13775" pdu="ethernet:EthernetII"><preamble minByteLength="4" >55555555555555d5</preamble><dstMac>00:10:94:00:00:01</dstMac><srcMac>00:10:94:00:00:03</srcMac></pdu></pdus></config></frame>} \
        -Name {StreamBlock 79-3-1} ]

set OsePortConfig(3) [lindex [stc::get $Port(3) -children-OsePortConfig] 0]


set OvsdbPortConfig(3) [lindex [stc::get $Port(3) -children-OvsdbPortConfig] 0]
stc::config $OvsdbPortConfig(3) \
        -CaCertificates {}

set VxlanPortConfig(3) [lindex [stc::get $Port(3) -children-VxlanPortConfig] 0]


set AppPerfPortConfig(3) [lindex [stc::get $Port(3) -children-AppPerfPortConfig] 0]


set EmulatedDeviceGenParams(1) [stc::create "EmulatedDeviceGenParams" \
        -under $Project(1) \
        -DeviceTags {} \
        -StepOrder {} ]

set DeviceGenIpv4IfParams(1) [stc::create "DeviceGenIpv4IfParams" \
        -under $EmulatedDeviceGenParams(1) ]

set DeviceGenEthIIIfParams(1) [stc::create "DeviceGenEthIIIfParams" \
        -under $EmulatedDeviceGenParams(1) ]

set DeviceRole(1) [stc::create "DeviceRole" \
        -under $Project(1) \
        -Name {Host} ]

set DeviceRole(2) [stc::create "DeviceRole" \
        -under $Project(1) \
        -Name {Router} ]

set EmulatedDevice(1) [stc::create "EmulatedDevice" \
        -under $Project(1) ]

set Ipv4If(4) [stc::create "Ipv4If" \
        -under $EmulatedDevice(1) \
        -AddrList "" \
        -GatewayList "" \
        -GatewayMac "00:00:00:00:00:00" ]

set EthIIIf(4) [stc::create "EthIIIf" \
        -under $EmulatedDevice(1) \
        -SourceMac "00:10:94:00:00:01" \
        -SrcMacList "" ]

set EmulatedDevice(2) [stc::create "EmulatedDevice" \
        -under $Project(1) \
        -RouterId "192.0.1.1" ]

set Ipv4If(5) [stc::create "Ipv4If" \
        -under $EmulatedDevice(2) \
        -Address "192.85.1.4" \
        -AddrList "" \
        -GatewayList "" \
        -GatewayMac "00:00:00:00:00:00" ]

set EthIIIf(5) [stc::create "EthIIIf" \
        -under $EmulatedDevice(2) \
        -SrcMacList "" ]

set EmulatedDevice(3) [stc::create "EmulatedDevice" \
        -under $Project(1) \
        -RouterId "192.0.2.1" ]

set Ipv4If(6) [stc::create "Ipv4If" \
        -under $EmulatedDevice(3) \
        -Address "192.85.1.5" \
        -AddrList "" \
        -GatewayList "" \
        -GatewayMac "00:00:00:00:00:00" ]

set EthIIIf(6) [stc::create "EthIIIf" \
        -under $EmulatedDevice(3) \
        -SourceMac "00:10:94:00:00:03" \
        -SrcMacList "" ]

set ExposedConfig(1) [stc::create "ExposedConfig" \
        -under $Project(1) ]

set RxPortResultFilter(1) [stc::create "RxPortResultFilter" \
        -under $Project(1) ]

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
        -PropertyIdArray "generatorportresults.totalframecount generatorportresults.totaloctetcount generatorportresults.generatorframecount generatorportresults.generatoroctetcount generatorportresults.generatorsigframecount generatorportresults.generatorundersizeframecount generatorportresults.generatoroversizeframecount generatorportresults.generatorjumboframecount generatorportresults.totalframerate generatorportresults.totaloctetrate generatorportresults.generatorframerate generatorportresults.generatoroctetrate generatorportresults.generatorsigframerate generatorportresults.generatorundersizeframerate generatorportresults.generatoroversizeframerate generatorportresults.generatorjumboframerate generatorportresults.generatorcrcerrorframecount generatorportresults.generatorl3checksumerrorcount generatorportresults.generatorl4checksumerrorcount generatorportresults.generatorcrcerrorframerate generatorportresults.generatorl3checksumerrorrate generatorportresults.generatorl4checksumerrorrate generatorportresults.totalipv4framecount generatorportresults.totalipv6framecount generatorportresults.totalmplsframecount generatorportresults.generatoripv4framecount generatorportresults.generatoripv6framecount generatorportresults.generatorvlanframecount generatorportresults.generatormplsframecount generatorportresults.totalipv4framerate generatorportresults.totalipv6framerate generatorportresults.totalmplsframerate generatorportresults.generatoripv4framerate generatorportresults.generatoripv6framerate generatorportresults.generatorvlanframerate generatorportresults.generatormplsframerate generatorportresults.totalbitrate generatorportresults.generatorbitrate generatorportresults.l1bitcount generatorportresults.l1bitrate generatorportresults.pfcframecount generatorportresults.pfcpri0framecount generatorportresults.pfcpri1framecount generatorportresults.pfcpri2framecount generatorportresults.pfcpri3framecount generatorportresults.pfcpri4framecount generatorportresults.pfcpri5framecount generatorportresults.pfcpri6framecount generatorportresults.pfcpri7framecount" ]

set ResultQuery(2) [stc::create "ResultQuery" \
        -under $ResultDataSet(1) \
        -ConfigClassId "analyzer" \
        -ResultClassId "analyzerportresults" \
        -PropertyIdArray "analyzerportresults.totalframecount analyzerportresults.totaloctetcount analyzerportresults.sigframecount analyzerportresults.undersizeframecount analyzerportresults.oversizeframecount analyzerportresults.jumboframecount analyzerportresults.minframelength analyzerportresults.maxframelength analyzerportresults.pauseframecount analyzerportresults.totalframerate analyzerportresults.totaloctetrate analyzerportresults.sigframerate analyzerportresults.undersizeframerate analyzerportresults.oversizeframerate analyzerportresults.jumboframerate analyzerportresults.pauseframerate analyzerportresults.fcserrorframecount analyzerportresults.ipv4checksumerrorcount analyzerportresults.tcpchecksumerrorcount analyzerportresults.udpchecksumerrorcount analyzerportresults.prbsfilloctetcount analyzerportresults.prbsbiterrorcount analyzerportresults.fcserrorframerate analyzerportresults.ipv4checksumerrorrate analyzerportresults.tcpchecksumerrorrate analyzerportresults.udpchecksumerrorrate analyzerportresults.prbsfilloctetrate analyzerportresults.prbsbiterrorrate analyzerportresults.ipv4framecount analyzerportresults.ipv6framecount analyzerportresults.ipv6overipv4framecount analyzerportresults.tcpframecount analyzerportresults.udpframecount analyzerportresults.mplsframecount analyzerportresults.icmpframecount analyzerportresults.vlanframecount analyzerportresults.ipv4framerate analyzerportresults.ipv6framerate analyzerportresults.ipv6overipv4framerate analyzerportresults.tcpframerate analyzerportresults.udpframerate analyzerportresults.mplsframerate analyzerportresults.icmpframerate analyzerportresults.vlanframerate analyzerportresults.trigger1count analyzerportresults.trigger1rate analyzerportresults.trigger2count analyzerportresults.trigger2rate analyzerportresults.trigger3count analyzerportresults.trigger3rate analyzerportresults.trigger4count analyzerportresults.trigger4rate analyzerportresults.trigger5count analyzerportresults.trigger5rate analyzerportresults.trigger6count analyzerportresults.trigger6rate analyzerportresults.trigger7count analyzerportresults.trigger7rate analyzerportresults.trigger8count analyzerportresults.trigger8rate analyzerportresults.combotriggercount analyzerportresults.combotriggerrate analyzerportresults.totalbitrate analyzerportresults.prbsbiterrorratio analyzerportresults.vlanframerate analyzerportresults.l1bitcount analyzerportresults.l1bitrate analyzerportresults.pfcframecount analyzerportresults.fcoeframecount analyzerportresults.pfcframerate analyzerportresults.fcoeframerate analyzerportresults.pfcpri0framecount analyzerportresults.pfcpri1framecount analyzerportresults.pfcpri2framecount analyzerportresults.pfcpri3framecount analyzerportresults.pfcpri4framecount analyzerportresults.pfcpri5framecount analyzerportresults.pfcpri6framecount analyzerportresults.pfcpri7framecount analyzerportresults.pfcpri0quanta analyzerportresults.pfcpri1quanta analyzerportresults.pfcpri2quanta analyzerportresults.pfcpri3quanta analyzerportresults.pfcpri4quanta analyzerportresults.pfcpri5quanta analyzerportresults.pfcpri6quanta analyzerportresults.pfcpri7quanta analyzerportresults.prbserrorframecount analyzerportresults.prbserrorframerate analyzerportresults.userdefinedframecount1 analyzerportresults.userdefinedframerate1 analyzerportresults.userdefinedframecount2 analyzerportresults.userdefinedframerate2 analyzerportresults.userdefinedframecount3 analyzerportresults.userdefinedframerate3 analyzerportresults.userdefinedframecount4 analyzerportresults.userdefinedframerate4 analyzerportresults.userdefinedframecount5 analyzerportresults.userdefinedframerate5 analyzerportresults.userdefinedframecount6 analyzerportresults.userdefinedframerate6" ]

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
        -ColumnPropertyName {GeneratorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "148" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(13) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorSigFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "167" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(14) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {SigFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "130" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(15) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "111" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(16) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "111" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(17) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "120" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(18) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOctetRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "123" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(19) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorBitRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "131" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(20) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorSigFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "139" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(21) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {SigFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "102" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(22) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcsErrorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "197" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(23) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorCrcErrorFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "201" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(24) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL3ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(25) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL4ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(26) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "171" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(27) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "168" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(28) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpChecksumErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "170" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(29) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsFillOctetCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "148" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(30) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "137" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(31) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorRatio} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(32) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcsErrorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "134" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(33) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorCrcErrorFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "172" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(34) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL3ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "230" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(35) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorL4ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "230" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(36) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "164" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(37) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "162" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(38) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpChecksumErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "163" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(39) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsBitErrorRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "169" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(40) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger1Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(41) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger2Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(42) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger3Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(43) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger4Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(44) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger5Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(45) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger6Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(46) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger7Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(47) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger8Count} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(48) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {ComboTriggerCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "87" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(49) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger1Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(50) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger2Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(51) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger3Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(52) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger4Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(53) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger5Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(54) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger6Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(55) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger7Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(56) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Trigger8Rate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(57) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {ComboTriggerRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "114" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(58) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "86" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(59) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalIpv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "88" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(60) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalMplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "91" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(61) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "129" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(62) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(63) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorVlanFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(64) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorMplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "132" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(65) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(66) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv6FrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "124" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(67) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "122" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(68) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "120" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(69) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {MplsFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(70) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {IcmpFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(71) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {VlanFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "113" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(72) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "87" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(73) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcoeFrameCount} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "96" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(74) [stc::create "RealTimeResultColumnDefinition" \
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

set RealTimeResultColumnDefinition(75) [stc::create "RealTimeResultColumnDefinition" \
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
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount TotalBitCount TotalBitCount TotalBitRate TotalBitRate L1BitCount L1BitCount L1BitRate L1BitRate GeneratorFrameCount GeneratorSigFrameCount SigFrameCount TotalFrameRate TotalFrameRate GeneratorFrameRate GeneratorOctetRate GeneratorBitRate GeneratorSigFrameRate SigFrameRate} \
        -SqlString { SELECT Port.Name AS 'Port Name', GeneratorPortResults.TotalFrameCount AS 'Total Tx Count (Frames)', AnalyzerPortResults.TotalFrameCount AS 'Total Rx Count (Frames)', GeneratorPortResults.GeneratorFrameCount AS 'Generator Count (Frames)', GeneratorPortResults.GeneratorSigFrameCount AS 'Generator Sig Count (Frames)', AnalyzerPortResults.SigFrameCount AS 'Rx Sig Count (Frames)', (GeneratorPortResults.TotalOctetCount * 8) AS 'Total Tx  Count (bits)', (AnalyzerPortResults.TotalOctetCount * 8) AS 'Total Rx Count (bits)', GeneratorPortResults.L1BitCount AS 'Tx L1 Count (bits)', AnalyzerPortResults.L1BitCount AS 'Rx L1 Count (bits)', AnalyzerPortResults.MinFrameLength AS 'Rx Min FrameLength', AnalyzerPortResults.MaxFrameLength AS 'Rx Max FrameLength', GeneratorPortResults.TotalCellCount AS 'Total Tx Count (Cells)', AnalyzerPortResults.TotalCellCount AS 'Total Rx Count (Cells)' FROM Port, GeneratorPortResults, Generator, AnalyzerPortResults, Analyzer WHERE ( Generator.ParentHnd = Port.Handle AND Analyzer.ParentHnd = Port.Handle AND GeneratorPortResults.ParentHnd = Generator.Handle AND AnalyzerPortResults.ParentHnd = Analyzer.Handle AND Port.DataSetId = @DataSetId AND GeneratorPortResults.DataSetId = @DataSetId AND Generator.DataSetId = @DataSetId AND AnalyzerPortResults.DataSetId = @DataSetId AND Analyzer.DataSetId = @DataSetId  )} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(3) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(1) \
        -GroupName {Errors} \
        -GroupId {object://customgroup/e26c15e5-fb73-46ad-a76b-45304a4e6303/Errors} \
        -ColumnClassName {GeneratorPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults GeneratorPortResults GeneratorPortResults GeneratorPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults AnalyzerPortResults} \
        -ColumnPropertyName {TotalFrameCount TotalFrameCount FcsErrorFrameCount GeneratorCrcErrorFrameCount GeneratorL3ChecksumErrorCount GeneratorL4ChecksumErrorCount Ipv4ChecksumErrorCount TcpChecksumErrorCount UdpChecksumErrorCount PrbsFillOctetCount PrbsBitErrorCount PrbsBitErrorRatio PrbsErrorFrameCount FcsErrorFrameRate GeneratorCrcErrorFrameRate GeneratorL3ChecksumErrorRate GeneratorL4ChecksumErrorRate Ipv4ChecksumErrorRate TcpChecksumErrorRate UdpChecksumErrorRate PrbsBitErrorRate PrbsErrorFrameRate} \
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

set RealTimeResultColumnDefinition(76) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {TotalMplsFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "90" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(77) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv4FrameRate} \
        -ColumnWidth "115" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(78) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorIpv6FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "117" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(79) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorVlanFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "127" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(80) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorMplsFrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(81) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv4FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "114" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(82) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {Ipv6FrameRate} \
        -ColumnDescription {DescribeMe} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(83) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {TcpFrameRate} \
        -ColumnWidth "77" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(84) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UdpFrameRate} \
        -ColumnWidth "84" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(85) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {MplsFrameRate} \
        -ColumnWidth "86" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(86) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {IcmpFrameRate} \
        -ColumnWidth "79" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(87) [stc::create "RealTimeResultColumnDefinition" \
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

set RealTimeResultColumnDefinition(88) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcFrameRate} \
        -ColumnWidth "93" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(89) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {FcoeFrameRate} \
        -ColumnWidth "93" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(90) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorUndersizeFrameCount} \
        -ColumnWidth "200" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(91) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UndersizeFrameCount} \
        -ColumnWidth "198" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(92) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOversizeFrameCount} \
        -ColumnWidth "194" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(93) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {OversizeFrameCount} \
        -ColumnWidth "192" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(94) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorJumboFrameCount} \
        -ColumnWidth "185" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(95) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {JumboFrameCount} \
        -ColumnWidth "182" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(96) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PauseFrameCount} \
        -ColumnWidth "179" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(97) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorUndersizeFrameRate} \
        -ColumnWidth "172" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(98) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UndersizeFrameRate} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(99) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorOversizeFrameRate} \
        -ColumnWidth "166" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(100) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {OversizeFrameRate} \
        -ColumnWidth "129" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(101) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {GeneratorJumboFrameRate} \
        -ColumnWidth "191" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(102) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {JumboFrameRate} \
        -ColumnWidth "119" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(103) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PauseFrameRate} \
        -ColumnWidth "89" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(104) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcFrameCount} \
        -ColumnWidth "96" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(105) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri0FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(106) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri1FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(107) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri2FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(108) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri3FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(109) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri4FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(110) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri5FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(111) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri6FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(112) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {GeneratorPortResults} \
        -ColumnPropertyName {PfcPri7FrameCount} \
        -ColumnWidth "108" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(113) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri0FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(114) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri1FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(115) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri2FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(116) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri3FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(117) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri4FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(118) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri5FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(119) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PfcPri6FrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(120) [stc::create "RealTimeResultColumnDefinition" \
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

set RealTimeResultColumnDefinition(121) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsErrorFrameCount} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(122) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {PrbsErrorFrameRate} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(123) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount1} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(124) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate1} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(125) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount2} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(126) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate2} \
        -ColumnWidth "109" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(127) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount3} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(128) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate3} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(129) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount4} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(130) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate4} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(131) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount5} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(132) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameRate5} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(133) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(1) \
        -ColumnClassName {AnalyzerPortResults} \
        -ColumnPropertyName {UserDefinedFrameCount6} \
        -ColumnWidth "135" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(134) [stc::create "RealTimeResultColumnDefinition" \
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

set ResultDataSet(2) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {TxStreamResults} \
        -RecordsPerPage "25" \
        -Identifier {Stream Results\Detailed Stream Results} \
        -Path {Stream Results} \
        -Description {object://l2l3/TxStreamResults} \
        -CustomDisplayPath {Streams} \
        -Name {Detailed Stream Results} ]

set RealTimeResultGroupDefinition(9) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {All Groups} \
        -GroupId {core://allgroups/} \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {StreamInfo} ]

set RealTimeResultGroupDefinition(10) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {Basic Counters} \
        -GroupId {object://customgroup/a7d38eca-b341-4d2f-9c5b-400e46180add/Basic Counters} \
        -ColumnClassName {Port RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults TxStreamResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults TxStreamResults} \
        -ColumnPropertyName {Name PortUiName AggregatedRxPortCount PortStrayFrames FrameCount FrameCount BitRate BitRate BitCount BitCount L1BitCount L1BitCount L1BitRate L1BitRate FrameRate FrameRate SigFrameCount SigFrameRate ShortTermAvgLatency AvgLatency MinLatency MaxLatency ShortTermAvgJitter AvgJitter Rfc4689AbsoluteAvgJitter MinJitter MaxJitter ShortTermAvgInterarrivalTime AvgInterarrivalTime MinInterarrivalTime MaxInterarrivalTime ExpectedRxFrameCount} \
        -SqlString {select TxPortName as 'Tx Port', group_concat(distinct ActualRxPortName) as 'Rx Port', TxStreamBlockName as 'Stream Block', TxStreamId as 'Stream Id', TxStreamIndex as 'Stream Index', (case when MIN(coalesce(IsExpectedPort,1)) = 0 then 'YES' else 'NO' end) as 'Port Stray Frames', TxFrameCount as 'Tx Count (Frames)', coalesce(sum(FrameCount), 0) as 'Rx Count (Frames)', coalesce(sum(SigFrameCount), 0) as 'Sig Count (Frames)', (TxOctetCount * 8) as 'Tx Count (bits)', coalesce(sum(OctetCount * 8), 0) as 'Rx Count (bits)', TxL1BitCount as 'Tx L1 Count (bits)', coalesce(sum(L1BitCount), 0) as 'Rx L1 Count (bits)', coalesce(round(cast(sum(TotalLatency) / 100.0 as double) / sum(SigFrameCount), 3), '0.0')as 'Avg Latency(us)', coalesce(min(MinLatency), '0.0') as 'Min Latency(us)', coalesce(max(MaxLatency), '0.0') as 'Max Latency(us)', (case when (sum(ModInSeqFrameCount)) < 0 then 'N/A' else coalesce(round(cast(sum(TotalJitter) / 100.0 as double) / sum(ModInSeqFrameCount), 3), 0.0) end) as 'Avg Jitter (us)',(case when (sum(ModSigFrameCount)) < 0 then 'N/A' else coalesce(round(cast(sum(TotalJitter) / 100.0 as double) / sum(ModSigFrameCount), 3), 0.0) end) as 'RFC4689 Absolute Avg Jitter (us)', coalesce(min(MinJitter), 0.0) as 'Min Jitter(us)', coalesce(max(MaxJitter), 0.0) as 'Max Jitter(us)', coalesce(round(cast(sum(TotalInterarrivalTime) / 100.0 as double) / sum(ModFrameCount), 3), 0.0) as 'Avg Interarrival Time(us)', coalesce(min(MinInterarrivalTime), 0.0) as 'Min Interarrival Time(us)', coalesce(max(MaxInterarrivalTime), 0.0) as 'Max Interarrival Time(us)', TxCellCount as 'Tx Count (Cells)', coalesce(sum(CellCount), 0) as 'Rx Count (Cells)' from TxRxEotStreamResults where 1 group by DataSetId, TxStreamId} \
        -UseCustomSqlString "TRUE" ]

set ResultQuery(3) [stc::create "ResultQuery" \
        -under $ResultDataSet(2) \
        -ConfigClassId "streamblock" \
        -ResultClassId "rxstreamsummaryresults" \
        -PropertyIdArray "rxbasicresults.framecount rxbasicresults.sigframecount rxbasicresults.fcserrorframecount rxbasicresults.minlatency rxbasicresults.maxlatency rxbasicresults.droppedframecount rxbasicresults.droppedframepercent rxbasicresults.inorderframecount rxbasicresults.reorderedframecount rxbasicresults.duplicateframecount rxbasicresults.lateframecount rxbasicresults.prbsbiterrorcount rxbasicresults.prbsfilloctetcount rxbasicresults.ipv4checksumerrorcount rxbasicresults.tcpudpchecksumerrorcount rxbasicresults.framerate rxbasicresults.sigframerate rxbasicresults.fcserrorframerate rxbasicresults.droppedframerate rxbasicresults.droppedframepercentrate rxbasicresults.inorderframerate rxbasicresults.reorderedframerate rxbasicresults.duplicateframerate rxbasicresults.lateframerate rxbasicresults.prbsbiterrorrate rxbasicresults.prbsfilloctetrate rxbasicresults.ipv4checksumerrorrate rxbasicresults.tcpudpchecksumerrorrate rxbasicresults.bitrate rxbasicresults.shorttermavglatency rxbasicresults.avglatency rxbasicresults.prbsbiterrorratio rxbasicresults.l1bitcount rxbasicresults.l1bitrate rxbasicresults.prbserrorframecount rxbasicresults.prbserrorframerate rxbasicresults.portstrayframes rxbasicresults.bitcount rxbasicresults.shorttermavgjitter rxbasicresults.avgjitter rxbasicresults.rfc4689absoluteavgjitter rxbasicresults.minjitter rxbasicresults.maxjitter rxbasicresults.shorttermavginterarrivaltime rxbasicresults.avginterarrivaltime rxbasicresults.mininterarrivaltime rxbasicresults.maxinterarrivaltime rxbasicresults.inseqframecount rxbasicresults.outseqframecount rxbasicresults.inseqframerate rxbasicresults.outseqframerate rxbasicresults.histbin1count rxbasicresults.histbin2count rxbasicresults.histbin3count rxbasicresults.histbin4count rxbasicresults.histbin5count rxbasicresults.histbin6count rxbasicresults.histbin7count rxbasicresults.histbin8count rxbasicresults.histbin9count rxbasicresults.histbin10count rxbasicresults.histbin11count rxbasicresults.histbin12count rxbasicresults.histbin13count rxbasicresults.histbin14count rxbasicresults.histbin15count rxbasicresults.histbin16count rxstreamsummaryresults.aggregatedrxportcount" \
        -ResultOptions {Basic} ]

set ResultQuery(4) [stc::create "ResultQuery" \
        -under $ResultDataSet(2) \
        -ConfigClassId "streamblock" \
        -ResultClassId "txstreamresults" \
        -PropertyIdArray "txbasicresults.framecount txbasicresults.framerate txbasicresults.bitrate txstreamresults.expectedrxframecount txbasicresults.l1bitcount txbasicresults.l1bitrate txbasicresults.bitcount txstreamresults.streaminfo" \
        -ResultOptions {Basic} ]

set RealTimeResultColumnDefinition(135) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {StreamInfo} \
        -ColumnWidth "74" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(136) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {Port} \
        -ColumnPropertyName {Name} \
        -ColumnWidth "85" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(137) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PortUiName} \
        -ColumnWidth "65" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(138) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {AggregatedRxPortCount} \
        -ColumnWidth "85" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(139) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PortStrayFrames} \
        -ColumnWidth "75" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(140) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {FrameCount} \
        -ColumnWidth "97" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(141) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {FrameCount} \
        -ColumnWidth "97" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(142) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {BitRate} \
        -ColumnWidth "100" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(143) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {BitRate} \
        -ColumnWidth "100" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(144) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {BitCount} \
        -ColumnWidth "100" \
        -ColumnUnits "1" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(145) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {BitCount} \
        -ColumnWidth "100" \
        -ColumnUnits "1" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(146) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {L1BitCount} \
        -ColumnWidth "100" \
        -ColumnUnits "1" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(147) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {L1BitCount} \
        -ColumnWidth "100" \
        -ColumnUnits "1" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(148) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {L1BitRate} \
        -ColumnWidth "100" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(149) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {L1BitRate} \
        -ColumnWidth "100" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(150) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {FrameRate} \
        -ColumnWidth "90" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(151) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {FrameRate} \
        -ColumnWidth "91" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(152) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {SigFrameCount} \
        -ColumnWidth "116" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(153) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {SigFrameRate} \
        -ColumnWidth "109" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(154) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {ShortTermAvgLatency} \
        -ColumnWidth "123" \
        -ColumnUnits "9" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(155) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {AvgLatency} \
        -ColumnWidth "123" \
        -ColumnUnits "9" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(156) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MinLatency} \
        -ColumnWidth "100" \
        -ColumnUnits "9" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(157) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MaxLatency} \
        -ColumnWidth "103" \
        -ColumnUnits "9" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(158) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {ShortTermAvgJitter} \
        -ColumnWidth "123" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(159) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {AvgJitter} \
        -ColumnWidth "123" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(160) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {Rfc4689AbsoluteAvgJitter} \
        -ColumnWidth "100" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(161) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MinJitter} \
        -ColumnWidth "100" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(162) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MaxJitter} \
        -ColumnWidth "103" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(163) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {ShortTermAvgInterarrivalTime} \
        -ColumnWidth "123" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(164) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {AvgInterarrivalTime} \
        -ColumnWidth "123" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(165) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MinInterarrivalTime} \
        -ColumnWidth "100" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(166) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {MaxInterarrivalTime} \
        -ColumnWidth "103" \
        -ColumnUnits "22" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(167) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {TxStreamResults} \
        -ColumnPropertyName {ExpectedRxFrameCount} \
        -ColumnWidth "85" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(168) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorCount} \
        -ColumnWidth "171" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(169) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {TcpUdpChecksumErrorCount} \
        -ColumnWidth "194" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(170) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsBitErrorCount} \
        -ColumnWidth "121" \
        -ColumnUnits "1" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(171) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsFillOctetCount} \
        -ColumnWidth "123" \
        -ColumnUnits "12" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(172) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsBitErrorRatio} \
        -ColumnWidth "100" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(173) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {FcsErrorFrameCount} \
        -ColumnWidth "148" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(174) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {Ipv4ChecksumErrorRate} \
        -ColumnWidth "164" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(175) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {TcpUdpChecksumErrorRate} \
        -ColumnWidth "187" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(176) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsBitErrorRate} \
        -ColumnWidth "130" \
        -ColumnUnits "5" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(177) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsFillOctetRate} \
        -ColumnWidth "117" \
        -ColumnUnits "18" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(178) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {FcsErrorFrameRate} \
        -ColumnWidth "141" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(179) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsErrorFrameCount} \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(180) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {PrbsErrorFrameRate} \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(181) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {InSeqFrameCount} \
        -ColumnWidth "147" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(182) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {OutSeqFrameCount} \
        -ColumnWidth "170" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(183) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {InSeqFrameRate} \
        -ColumnWidth "140" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(184) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {OutSeqFrameRate} \
        -ColumnWidth "161" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(185) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DroppedFrameCount} \
        -ColumnWidth "127" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(186) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DroppedFramePercent} \
        -ColumnWidth "125" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(187) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {InOrderFrameCount} \
        -ColumnWidth "126" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(188) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {ReorderedFrameCount} \
        -ColumnWidth "136" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(189) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DuplicateFrameCount} \
        -ColumnWidth "131" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(190) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {LateFrameCount} \
        -ColumnWidth "106" \
        -ColumnUnits "16" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(191) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DroppedFrameRate} \
        -ColumnWidth "121" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(192) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DroppedFramePercentRate} \
        -ColumnWidth "85" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(193) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {InOrderFrameRate} \
        -ColumnWidth "119" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(194) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {ReorderedFrameRate} \
        -ColumnWidth "130" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(195) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {DuplicateFrameRate} \
        -ColumnWidth "124" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(196) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {LateFrameRate} \
        -ColumnWidth "99" \
        -ColumnUnits "17" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(197) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin1Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(198) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin2Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultGroupDefinition(11) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {Errors} \
        -GroupId {object://customgroup/1334ba8f-a144-4069-8cb7-11633334149f/Errors} \
        -ColumnClassName {Port RxStreamSummaryResults TxStreamResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults} \
        -ColumnPropertyName {Name PortUiName FrameCount FrameCount Ipv4ChecksumErrorCount TcpUdpChecksumErrorCount PrbsBitErrorCount PrbsFillOctetCount PrbsBitErrorRatio FcsErrorFrameCount Ipv4ChecksumErrorRate TcpUdpChecksumErrorRate PrbsBitErrorRate PrbsFillOctetRate FcsErrorFrameRate PrbsErrorFrameCount PrbsErrorFrameRate} \
        -SqlString {select TxPortName as 'Tx Port', group_concat(distinct ActualRxPortName) as 'Rx Port', TxStreamBlockName as 'Stream Block', TxStreamId as 'Stream Id', TxStreamIndex as 'Stream Index', TxFrameCount as 'Tx Count (Frames)',  coalesce(sum(FrameCount), 0) as 'Rx Count (Frames)', coalesce(sum(Ipv4ChecksumErrorCount), 0) as 'Rx IPv4 Checksum Error Count', coalesce(sum(TcpUdpChecksumErrorCount), 0) as 'Rx TCP/UDP Checksum Error Count', coalesce(sum(PrbsBitErrorCount), 0) as 'PRBS Bit Error Count', coalesce(sum(PrbsFillOctetCount), 0) as 'PRBS Fill Octet Count', coalesce(cast(sum(PrbsBitErrorCount)*8 as double)/sum(PrbsFillOctetCount), 0.0) as 'PRBS Bit Error Ratio', coalesce(sum(FcsErrorFrameCount), 0) as 'Rx FCS Error Count (Frames)', coalesce(sum(PrbsErrorFrameCount), 0) as 'PRBS Error Frame Count' from TxRxEotStreamResults where 1 group by DataSetId, TxStreamId} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(12) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {Basic Sequencing} \
        -GroupId {object://customgroup/e652f0ae-e04e-4f5b-922e-f6a0a21e9347/Basic Sequencing} \
        -ColumnClassName {Port RxStreamSummaryResults TxStreamResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults} \
        -ColumnPropertyName {Name PortUiName FrameCount FrameCount InSeqFrameCount OutSeqFrameCount InSeqFrameRate OutSeqFrameRate} \
        -SqlString {select TxPortName as 'Tx Port', group_concat(distinct ActualRxPortName) as 'Rx Port', TxStreamBlockName as 'Stream Block', TxStreamId as 'Stream Id', TxStreamIndex as 'Stream Index', TxFrameCount as 'Tx Count (Frames)', coalesce(sum(FrameCount), 0) as 'Rx Count (Frames)', coalesce(sum(SeqRunLength), 0) as 'Sequence Run Length', coalesce(sum(InSeqFrameCount), 0) as 'In Seq Count (Frames)', coalesce(sum(OutSeqFrameCount), 0) as 'Out of Seq Count (Frames)' from TxRxEotStreamResults where 1 group by DataSetId, TxStreamId} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(13) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {Advanced Sequencing} \
        -GroupId {object://customgroup/3d3639f4-a55b-4466-8e16-2e7c6a70afa7/Advanced Sequencing} \
        -ColumnClassName {Port RxStreamSummaryResults TxStreamResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults} \
        -ColumnPropertyName {Name PortUiName FrameCount FrameCount DroppedFrameCount DroppedFramePercent InOrderFrameCount ReorderedFrameCount DuplicateFrameCount LateFrameCount DroppedFrameRate DroppedFramePercentRate InOrderFrameRate ReorderedFrameRate DuplicateFrameRate LateFrameRate} \
        -SqlString {select TxPortName as 'Tx Port', group_concat(distinct ActualRxPortName) as 'Rx Port', TxStreamBlockName as 'Stream Block', TxStreamId as  'Stream Id', TxStreamIndex as 'Stream Index', TxFrameCount as 'Tx Count (Frames)', coalesce(sum(FrameCount), 0) as 'Rx Count (Frames)', ExpectedRxFrameCount as 'Expected Rx Count (Frames)', (case when (ExpectedRxFrameCount - coalesce(sum(FrameCount), 0)) < 0 then 'N/A' else ExpectedRxFrameCount - coalesce(sum(FrameCount),0) end) as 'Tx-Rx (Frames)', (case when (ExpectedRxFrameCount - coalesce(sum(FrameCount), 0)) < 0 then 'N/A' else round(cast(ExpectedRxFrameCount - coalesce(sum(FrameCount), 0) as double) * 100.0 / ExpectedRxFrameCount, 5) end) as 'Tx-Rx (%)', coalesce(sum(DroppedFrameCount), 0) as 'Dropped Frame Count', round(cast(coalesce(sum(DroppedFrameCount), 0) as double) * 100.0 / ExpectedRxFrameCount, 5) as 'Dropped Frame (%)', coalesce(sum(InOrderFrameCount), 0) as 'In-order Frame Count', coalesce(sum(ReorderedFrameCount), 0) as 'Reordered Frame Count', coalesce(sum(DuplicateFrameCount), 0) as 'Duplicate Count (Frames)', coalesce(sum(LateFrameCount), 0) as 'Late Count (Frames)' from TxRxEotStreamResults where 1 group by DataSetId, TxStreamId} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultGroupDefinition(14) [stc::create "RealTimeResultGroupDefinition" \
        -under $ResultDataSet(2) \
        -GroupName {Histograms} \
        -GroupId {object://customgroup/a3fa4141-b6c7-4c1b-935b-df51d6118259/Histograms} \
        -ColumnClassName {Port RxStreamSummaryResults TxStreamResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults RxStreamSummaryResults} \
        -ColumnPropertyName {Name PortUiName FrameCount FrameCount HistBin1Count HistBin2Count HistBin3Count HistBin4Count HistBin5Count HistBin6Count HistBin7Count HistBin8Count HistBin9Count HistBin10Count HistBin11Count HistBin12Count HistBin13Count HistBin14Count HistBin15Count HistBin16Count} \
        -SqlString {select TxPortName as 'Tx Port', group_concat(distinct ActualRxPortName) as 'Rx Port', TxStreamBlockName as 'Stream Block', TxStreamId as 'Stream Id', TxStreamIndex as 'Stream Index', TxFrameCount as 'Tx Count (Frames)', coalesce(sum(FrameCount), 0) as 'Rx Count (Frames)', coalesce(sum(HistBin1Count), 0) as 'Bucket 1', coalesce(sum(HistBin2Count), 0) as 'Bucket 2', coalesce(sum(HistBin3Count), 0) as 'Bucket 3', coalesce(sum(HistBin4Count), 0) as 'Bucket 4', coalesce(sum(HistBin5Count), 0) as 'Bucket 5', coalesce(sum(HistBin6Count), 0) as 'Bucket 6', coalesce(sum(HistBin7Count), 0) as 'Bucket 7', coalesce(sum(HistBin8Count), 0) as 'Bucket 8', coalesce(sum(HistBin9Count), 0) as 'Bucket 9', coalesce(sum(HistBin10Count), 0) as 'Bucket 10', coalesce(sum(HistBin11Count), 0) as 'Bucket 11', coalesce(sum(HistBin12Count), 0) as 'Bucket 12', coalesce(sum(HistBin13Count), 0) as 'Bucket 13', coalesce(sum(HistBin14Count), 0) as 'Bucket 14', coalesce(sum(HistBin15Count), 0) as 'Bucket 15', coalesce(sum(HistBin16Count), 0) as 'Bucket 16' from TxRxEotStreamResults where 1 group by DataSetId, TxStreamId} \
        -UseCustomSqlString "TRUE" ]

set RealTimeResultColumnDefinition(199) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin3Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(200) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin4Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(201) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin5Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(202) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin6Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(203) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin7Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(204) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin8Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(205) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin9Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(206) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin10Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(207) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin11Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(208) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin12Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(209) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin13Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(210) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin14Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(211) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin15Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set RealTimeResultColumnDefinition(212) [stc::create "RealTimeResultColumnDefinition" \
        -under $ResultDataSet(2) \
        -ColumnClassName {RxStreamSummaryResults} \
        -ColumnPropertyName {HistBin16Count} \
        -ColumnWidth "70" \
        -ColumnUnits "0" \
        -ColumnPrecision "2" ]

set Perspective(1) [stc::create "Perspective" \
        -under $Project(1) \
        -PerspectiveViewOwner "USER" ]

set PerspectiveNode(1) [stc::create "PerspectiveNode" \
        -under $Perspective(1) \
        -Guid {8CF0ABC3-9F7C-46bd-A22E-00D88A8376D3} \
        -Data {<NodeData Name="resultFrame.1" FrameId="8CF0ABC3-9F7C-46bd-A22E-00D88A8376D3" Active="true" RowCount="1" ColumnCount="2" />} \
        -ContentData {<ContentData><NodeContentData FrameName="frame://core/Port/ResultQuery:(1, 0, 0)" ResultDataSetId="Port Traffic\Basic Traffic Results" Column="0" Row="0" DockPanelNumber="1" /><NodeContentData FrameName="frame://l2l3/TxStreamResults/ResultQuery:(1, 0, 1)" ResultDataSetId="Stream Results\Detailed Stream Results" Column="1" Row="0" DockPanelNumber="1" /></ContentData>

} ]

set PerspectiveNode(2) [stc::create "PerspectiveNode" \
        -under $Perspective(1) \
        -Guid {1F412EE6-760C-4937-9644-ACFA463EA44E} \
        -Data {<NodeData Name="resultFrame.2" FrameId="1F412EE6-760C-4937-9644-ACFA463EA44E" Active="false" RowCount="1" ColumnCount="2" />} \
        -ContentData {<ContentData />

} ]

set RxPortResultFilter(2) [stc::create "RxPortResultFilter" \
        -under $Project(1) ]

set ResultDataSet(3) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {Port} \
        -CreatorId {VerifyResultsValueCommand} ]

set ResultQuery(5) [stc::create "ResultQuery" \
        -under $ResultDataSet(3) \
        -ConfigClassId "analyzer" \
        -ResultClassId "analyzerportresults" \
        -PropertyIdArray "analyzerportresults.sigframecount" ]

set PortOptions(1) [lindex [stc::get $Project(1) -children-PortOptions] 0]


set MplsTpOamGlobalConfig(1) [lindex [stc::get $Project(1) -children-MplsTpOamGlobalConfig] 0]


set StreamBlockLoadProfile(1) [stc::create "StreamBlockLoadProfile" \
        -under $Project(1) ]

set StreamBlockLoadProfile(2) [stc::create "StreamBlockLoadProfile" \
        -under $Project(1) ]

set StreamBlockLoadProfile(3) [stc::create "StreamBlockLoadProfile" \
        -under $Project(1) ]

set ResultDataSet(4) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {Port} \
        -CreatorId {VerifyResultsValueCommand} ]

set ResultQuery(6) [stc::create "ResultQuery" \
        -under $ResultDataSet(4) \
        -ConfigClassId "generator" \
        -ResultClassId "generatorportresults" \
        -PropertyIdArray "generatorportresults.generatorsigframecount" ]

set ResultDataSet(5) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {Port} \
        -CreatorId {VerifyResultsValueCommand} ]

set ResultQuery(7) [stc::create "ResultQuery" \
        -under $ResultDataSet(5) \
        -ConfigClassId "analyzer" \
        -ResultClassId "analyzerportresults" \
        -PropertyIdArray "analyzerportresults.sigframecount" ]

set ResultDataSet(6) [stc::create "ResultDataSet" \
        -under $Project(1) \
        -PrimaryClass {Port} \
        -CreatorId {VerifyResultsValueCommand} ]

set ResultQuery(8) [stc::create "ResultQuery" \
        -under $ResultDataSet(6) \
        -ConfigClassId "analyzer" \
        -ResultClassId "analyzerportresults" \
        -PropertyIdArray "analyzerportresults.sigframecount" ]

set Ieee80211PhyOptions(1) [lindex [stc::get $Project(1) -children-Ieee80211PhyOptions] 0]


set RealismOptions(1) [lindex [stc::get $Project(1) -children-RealismOptions] 0]


set GroupHistogram(1) [lindex [stc::get $Project(1) -children-GroupHistogram] 0]


set MplsTpGlobalConfig(1) [lindex [stc::get $Project(1) -children-MplsTpGlobalConfig] 0]


set IsisGlobalConfig(1) [lindex [stc::get $Project(1) -children-IsisGlobalConfig] 0]


set OtvOptions(1) [lindex [stc::get $Project(1) -children-OtvOptions] 0]


set VxlanGlobalConfig(1) [lindex [stc::get $Project(1) -children-VxlanGlobalConfig] 0]


set PcepGlobalConfig(1) [lindex [stc::get $Project(1) -children-PcepGlobalConfig] 0]


set AutomationOptions(1) [lindex [stc::get $system1 -children-AutomationOptions] 0]
stc::config $AutomationOptions(1) \
        -AutoSubscribe "FALSE"

set PhysicalChassisManager(1) [stc::create "PhysicalChassisManager" \
        -under $system1 ]

set Sequencer(1) [stc::create "Sequencer" \
        -under $system1 ]

set VerifyResultsValueCommand(1) [stc::create "VerifyResultsValueCommand" \
        -under $Sequencer(1) ]

set SequencerIfCommand(1) [stc::create "SequencerIfCommand" \
        -under $Sequencer(1) ]

set L2LearningStartCommand(1) [stc::create "L2LearningStartCommand" \
        -under $Sequencer(1) \
        -Name {Learning: Start L2 Learning 1} ]

set ResultsClearAllCommand(1) [stc::create "ResultsClearAllCommand" \
        -under $Sequencer(1) ]

set GeneratorStartCommand(1) [stc::create "GeneratorStartCommand" \
        -under $Sequencer(1) ]

set GeneratorWaitForStopCommand(1) [stc::create "GeneratorWaitForStopCommand" \
        -under $Sequencer(1) \
        -WaitTimeout "60" ]

set WaitCommand(1) [stc::create "WaitCommand" \
        -under $Sequencer(1) \
        -WaitTime "1.5" ]

set SequencerIfCommand(2) [stc::create "SequencerIfCommand" \
        -under $Sequencer(1) \
        -Condition "FAILED" ]

set VerifyResultsValueCommand(2) [stc::create "VerifyResultsValueCommand" \
        -under $SequencerIfCommand(2) \
        -Name {Basic: Verify Result Value} ]

set VerifyResultsValueCondition(1) [stc::create "VerifyResultsValueCondition" \
        -under $VerifyResultsValueCommand(2) \
        -PropertyOperand {SigFrameCount} \
        -ValueOperand {500000} \
        -ComparisonOperator "EQUAL" \
        -MinValueOperand {500000} \
        -MaxValueOperand {500000} ]

set SequencerStopCommand(1) [stc::create "SequencerStopCommand" \
        -under $SequencerIfCommand(2) \
        -SequencerTestState "CHANGE_TO_FAILED" \
        -StoppedReason {Verify Rx Sig Frames == 500000} ]

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
stc::config $Port(1) -AffiliationPort-sources " $EmulatedDevice(1) "
stc::config $Port(1) -ActivePhy-targets " $EthernetCopper(1) "
stc::config $Port(2) -AffiliationPort-sources " $EmulatedDevice(2) "
stc::config $Port(2) -ActivePhy-targets " $EthernetCopper(2) "
stc::config $Port(3) -AffiliationPort-sources " $EmulatedDevice(3) "
stc::config $Port(3) -ActivePhy-targets " $EthernetCopper(3) "
stc::config $Tags(1) -DefaultTag-targets " $Tag(1) $Tag(2) $Tag(3) $Tag(4) $Tag(5) $Tag(6) "
stc::config $Host(1) -TopLevelIf-targets " $Ipv4If(1) $Ipv6If(1) $Ipv6If(2) "
stc::config $Ipv4If(1) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $Ipv6If(1) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $Ipv6If(2) -StackedOnEndpoint-targets " $EthIIIf(1) "
stc::config $AnalyzerConfig(1) -ActiveHistogram-targets " $LatencyHistogram(1) "
stc::config $StreamBlock(1) -SrcBinding-targets " $EthIIIf(4) "
stc::config $StreamBlock(1) -DstBinding-targets " $EthIIIf(5) "
stc::config $StreamBlock(1) -AffiliationFrameLengthDistribution-targets " $FrameLengthDistribution(1) "
stc::config $StreamBlock(1) -AffiliationStreamBlockLoadProfile-targets " $StreamBlockLoadProfile(1) "
stc::config $Host(2) -TopLevelIf-targets " $Ipv4If(2) $Ipv6If(3) $Ipv6If(4) "
stc::config $Ipv4If(2) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $Ipv6If(3) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $Ipv6If(4) -StackedOnEndpoint-targets " $EthIIIf(2) "
stc::config $AnalyzerConfig(2) -ActiveHistogram-targets " $LatencyHistogram(2) "
stc::config $StreamBlock(2) -SrcBinding-targets " $EthIIIf(5) "
stc::config $StreamBlock(2) -DstBinding-targets " $EthIIIf(6) "
stc::config $StreamBlock(2) -AffiliationFrameLengthDistribution-targets " $FrameLengthDistribution(1) "
stc::config $StreamBlock(2) -AffiliationStreamBlockLoadProfile-targets " $StreamBlockLoadProfile(2) "
stc::config $Host(3) -TopLevelIf-targets " $Ipv4If(3) $Ipv6If(5) $Ipv6If(6) "
stc::config $Ipv4If(3) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $Ipv6If(5) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $Ipv6If(6) -StackedOnEndpoint-targets " $EthIIIf(3) "
stc::config $AnalyzerConfig(3) -ActiveHistogram-targets " $LatencyHistogram(3) "
stc::config $StreamBlock(3) -SrcBinding-targets " $EthIIIf(6) "
stc::config $StreamBlock(3) -DstBinding-targets " $EthIIIf(4) "
stc::config $StreamBlock(3) -AffiliationFrameLengthDistribution-targets " $FrameLengthDistribution(1) "
stc::config $StreamBlock(3) -AffiliationStreamBlockLoadProfile-targets " $StreamBlockLoadProfile(3) "
stc::config $EmulatedDeviceGenParams(1) -SelectedPort-targets " $Port(1) $Port(2) $Port(3) "
stc::config $EmulatedDeviceGenParams(1) -DeviceGenTopLevelIf-targets " $DeviceGenIpv4IfParams(1) "
stc::config $DeviceGenIpv4IfParams(1) -DeviceGenStackedOnIf-targets " $DeviceGenEthIIIfParams(1) "
stc::config $EmulatedDevice(1) -TopLevelIf-targets " $Ipv4If(4) "
stc::config $EmulatedDevice(1) -PrimaryIf-targets " $Ipv4If(4) "
stc::config $Ipv4If(4) -StackedOnEndpoint-targets " $EthIIIf(4) "
stc::config $EmulatedDevice(2) -TopLevelIf-targets " $Ipv4If(5) "
stc::config $EmulatedDevice(2) -PrimaryIf-targets " $Ipv4If(5) "
stc::config $Ipv4If(5) -StackedOnEndpoint-targets " $EthIIIf(5) "
stc::config $EmulatedDevice(3) -TopLevelIf-targets " $Ipv4If(6) "
stc::config $EmulatedDevice(3) -PrimaryIf-targets " $Ipv4If(6) "
stc::config $Ipv4If(6) -StackedOnEndpoint-targets " $EthIIIf(6) "
stc::config $ResultQuery(3) -ResultFilters-targets " $RxPortResultFilter(2) "
stc::config $PerspectiveNode(1) -PerspectiveChild-targets " $ResultDataSet(1) $ResultDataSet(2) "
stc::config $PerspectiveNode(2) -PerspectiveChild-targets " $ResultDataSet(1) $ResultDataSet(2) "
stc::config $Sequencer(1) -SequencerFinalizeType-targets " $SequencerGroupCommand(1) "

# Set up handles
stc::config $GeneratorStartCommand(1) -GeneratorList "$Generator(1) $Generator(2) $Generator(3)"
stc::config $ResultQuery(6) -ResultRootList "$Project(1)"
stc::config $ResultQuery(6) -PropertyHandleArray ""
stc::config $GeneratorWaitForStopCommand(1) -GeneratorList "$Generator(1) $Generator(2) $Generator(3)"
stc::config $L2LearningStartCommand(1) -HandleList "$Port(1) $Port(2) $Port(3)"
stc::config $ResultQuery(7) -ResultRootList "$Project(1)"
stc::config $ResultQuery(7) -PropertyHandleArray ""
stc::config $ResultsClearAllCommand(1) -PortList "$Project(1)"
stc::config $SequencerIfCommand(2) -ExpressionCommand "$VerifyResultsValueCommand(2)"
stc::config $SequencerIfCommand(2) -CommandList "$SequencerStopCommand(1)"
stc::config $ResultQuery(8) -ResultRootList "$Project(1)"
stc::config $ResultQuery(8) -PropertyHandleArray ""
stc::config $SequencerIfCommand(1) -CommandList ""
stc::config $VerifyResultsValueCondition(1) -ResultQuery "$ResultQuery(8)"
stc::config $SequencerGroupCommand(1) -CommandList ""
stc::config $Sequencer(1) -CommandList "$L2LearningStartCommand(1) $ResultsClearAllCommand(1) $GeneratorStartCommand(1) $GeneratorWaitForStopCommand(1) $WaitCommand(1) $SequencerIfCommand(2)"
stc::config $Sequencer(1) -BreakpointList ""
stc::config $Sequencer(1) -DisabledCommandList ""
stc::config $Sequencer(1) -CleanupCommand "$SequencerGroupCommand(1)"
stc::config $RxPortResultFilter(2) -RxPortList ""
stc::config $RxPortResultFilter(1) -RxPortList ""
stc::config $ResultQuery(1) -ResultRootList "$Project(1)"
stc::config $ResultQuery(1) -PropertyHandleArray ""
stc::config $ResultQuery(2) -ResultRootList "$Project(1)"
stc::config $ResultQuery(2) -PropertyHandleArray ""
stc::config $ResultQuery(3) -ResultRootList "$Project(1)"
stc::config $ResultQuery(3) -PropertyHandleArray ""
stc::config $ResultQuery(4) -ResultRootList "$Project(1)"
stc::config $ResultQuery(4) -PropertyHandleArray ""
stc::config $ResultQuery(5) -ResultRootList "$Project(1)"
stc::config $ResultQuery(5) -PropertyHandleArray ""

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