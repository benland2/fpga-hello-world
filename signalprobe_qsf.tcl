# Copyright (C) 2025  Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus Prime License Agreement,
# the Altera IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Altera and sold by Altera or its authorized distributors.  Please
# refer to the Altera Software License Subscription Agreements 
# on the Quartus Prime software download page.


# Quartus Prime Version 24.1std.0 Build 1077 03/04/2025 SC Lite Edition
# File: signalprobe_qsf.tcl
# Generated on: Wed Nov  5 14:47:09 2025

# Note: This file contains a Tcl script generated from the Signal Probe Gui.
#       You can use this script to restore Signal Probes after deleting the DB
#       folder; at the command line use "quartus_cdb -t signalprobe_qsf.tcl".

package require ::quartus::chip_planner
package require ::quartus::project
project_open hdmi_text -revision hdmi_text
read_netlist
set had_failure 0

############
# Index: 1 #
############
set result [ make_sp  -src_name "|hdmi_text|clock50~input" -loc PIN_AA11 -pin_name "clock50_signalProbe" -io_std "2.5 V" ] 
if { $result == 0 } { 
	 puts "FAIL (clock50_signalProbe): make_sp  -src_name \"|hdmi_text|clock50~input\" -loc PIN_AA11 -pin_name \"clock50_signalProbe\" -io_std \"2.5 V\""
} else { 
 	 puts "SET  (clock50_signalProbe): make_sp  -src_name \"|hdmi_text|clock50~input\" -loc PIN_AA11 -pin_name \"clock50_signalProbe\" -io_std \"2.5 V\""
} 

