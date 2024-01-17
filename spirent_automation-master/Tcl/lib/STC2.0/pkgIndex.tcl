# SpirentTestCenter Tcl package index file.
# This file is sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  The installer
# must fill in the directory where SpirentTestCenter.tcl can
# be found; this may differ between SpirentTestCenter
# and SpirentTestCenterConformance depending on the platform.

set vers "4.70"


package ifneeded SpirentTestCenterConformance 4.70 "[list set env(STC_CONFIGURATION_FILE) ctsbll.ini]; [list source [file join CTS_INSTALL_DIR SpirentTestCenter.tcl]]; [list package provide SpirentTestCenterConformance 4.70]"
package ifneeded SpirentTestCenter 4.70 [list source [file join "C:/Program\ Files\ (x86)/Spirent\ Communications/Spirent\ TestCenter\ 4.70/Spirent\ TestCenter\ Application" SpirentTestCenter.tcl]]
package ifneeded stc 4.70 [list source [file join "C:/Program\ Files\ (x86)/Spirent\ Communications/Spirent\ TestCenter\ 4.70/Spirent\ TestCenter\ Application" SpirentTestCenter.tcl]]
package ifneeded stclib 4.70 [list source [file join "C:/Program\ Files\ (x86)/Spirent\ Communications/Spirent\ TestCenter\ 4.70/Spirent\ TestCenter\ Application" stclib.tcl]]