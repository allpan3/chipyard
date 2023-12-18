

### pt_setup.tcl file              ###




puts "RM-Info: Running script [info script]\n"
### Start of PrimeTime Runtime Variables ###

##########################################################################################
# PrimeTime Variables PrimeTime Reference Methodology script
# Script: pt_setup.tcl
# Version: I-2013.12 (January 13, 2014)
# Copyright (C) 2008-2014 Synopsys All rights reserved.
##########################################################################################


######################################
# Report and Results Directories
######################################


set REPORTS_DIR "reports"
set RESULTS_DIR "results"


######################################
# Library and Design Setup
######################################

### Mode : DMSA

set search_path ". $ADDITIONAL_SEARCH_PATH $search_path"
#set target_library $TARGET_LIBRARY_FILES
#set link_path "* $target_library $ADDITIONAL_LINK_LIB_FILES"


######################################
# DMSA File Section
######################################

set sh_source_uses_search_path true

# Provide a list of DMSA Corners : best_case, nom, worst_case
#
# The syntax is:
#		1.  set dmsa_corners "corner1 corner2 ..."

set SPEF_rcnom "../../../current-spef/SWERVETop_RCnom.spef.gz"
set SPEF_rcmin "../../../current-spef/SWERVETop_RCmin.spef.gz"
set SPEF_rcmax "../../../current-spef/SWERVETop_RCmax.spef.gz"

# TODO: what temperatures to use?  Try to get close to
# 25C if possible...

#set dmsa_corners "sv_ff_rcmax sv_ff_rcmin sv_ss_rcmax sv_ss_rcmin sv_tt_rcnom mv_ff_rcmax mv_ff_rcmin mv_ss_rcmax mv_ss_rcmin mv_tt_rcnom mv_dc_rcnom"
#set dmsa_corners "sv_ff_rcmax"
#set dmsa_corners "sv_ss_rcmax mv_ss_rcmax"
set dmsa_corners "sv_tt_rcnom sv_ff_rcmax"

# Provide an array of DMSA Corners Based Libraries : best_case, nom, worst_case
#
# The syntax is dmsa_corner_library_files(corner)
#		1. dmsa_corner_library_files(corner1)
#		2. dmsa_corner_library_files(corner2)

set dmsa_corner_library_files(sv_ff_rcmax) "$LIBS_sv_ff"
set dmsa_corner_library_files(sv_ff_rcmin) "$LIBS_sv_ff"
set dmsa_corner_library_files(sv_ss_rcmax) "$LIBS_sv_ss"
set dmsa_corner_library_files(sv_ss_rcmin) "$LIBS_sv_ss"
set dmsa_corner_library_files(sv_tt_rcnom) "$LIBS_sv_tt"
set dmsa_corner_library_files(mv_ff_rcmax) "$LIBS_mv_ff"
set dmsa_corner_library_files(mv_ff_rcmin) "$LIBS_mv_ff"
set dmsa_corner_library_files(mv_ss_rcmax) "$LIBS_mv_ss"
set dmsa_corner_library_files(mv_ss_rcmin) "$LIBS_mv_ss"
set dmsa_corner_library_files(mv_tt_rcnom) "$LIBS_mv_tt"
set dmsa_corner_library_files(mv_dc_rcnom) "$LIBS_mv_dc"

# Provide the UPF File
#
# The syntax is:
#		1. dmsa_UPF_FILE

set dmsa_UPF_FILE		"../../../../icc-par/current-icc/results/SWERVETop.output.upf"     


set dmsa_LPPI_FILE(sv_ff_rcmax) "sv_ff.lppi"
set dmsa_LPPI_FILE(sv_ff_rcmin) "sv_ff.lppi"
set dmsa_LPPI_FILE(sv_ss_rcmax) "sv_ss.lppi"
set dmsa_LPPI_FILE(sv_ss_rcmin) "sv_ss.lppi"
set dmsa_LPPI_FILE(sv_tt_rcnom) "sv_tt.lppi"
set dmsa_LPPI_FILE(mv_ff_rcmax) "mv_ff.lppi"
set dmsa_LPPI_FILE(mv_ff_rcmin) "mv_ff.lppi"
set dmsa_LPPI_FILE(mv_ss_rcmax) "mv_ss.lppi"
set dmsa_LPPI_FILE(mv_ss_rcmin) "mv_ss.lppi"
set dmsa_LPPI_FILE(mv_tt_rcnom) "mv_tt.lppi"
set dmsa_LPPI_FILE(mv_dc_rcnom) "mv_dc.lppi"


# Provide a list of DMSA modes   : functional, test
#
# The syntax is:
#               1.  set dmsa_modes "mode1 mode2 ..."

set dmsa_modes      "functional"

# Provide an array DMSA Modes Constraint Files 
# The syntax will be dmsa_mode_constraint_files(mode)
#		1. dmsa_mode_constraint_files(mode1)
#		2. dmsa_mode_constraint_files(mode2)
#

set dmsa_mode_constraint_files(sv_ff_rcmax) "sv_ff.sdc"
set dmsa_mode_constraint_files(sv_ff_rcmin) "sv_ff.sdc"
set dmsa_mode_constraint_files(sv_ss_rcmax) "sv_ss.sdc"
set dmsa_mode_constraint_files(sv_ss_rcmin) "sv_ss.sdc"
set dmsa_mode_constraint_files(sv_tt_rcnom) "sv_tt.sdc"
set dmsa_mode_constraint_files(mv_ff_rcmax) "mv_ff.sdc"
set dmsa_mode_constraint_files(mv_ff_rcmin) "mv_ff.sdc"
set dmsa_mode_constraint_files(mv_ss_rcmax) "mv_ss.sdc"
set dmsa_mode_constraint_files(mv_ss_rcmin) "mv_ss.sdc"
set dmsa_mode_constraint_files(mv_tt_rcnom) "mv_tt.sdc"
set dmsa_mode_constraint_files(mv_dc_rcnom) "mv_dc.sdc"


#
# Corner-Based Back Annotation Section
#
# The syntax is:
#		1. PARASITIC_FILES(corner1)
#		2. PARASITIC_PATHS(corner1)
#

# The path (instance name) and name of the parasitic file --- example "top.spef A.spef" 
# Each PARASITIC_PATH entry corresponds to the related PARASITIC_FILE for the specific block"   
# For a single toplevel PARASITIC file please use the toplevel design name in PARASITIC_PATHS variable."   
set PARASITIC_FILES(mv_ff_rcmax)	 "$SPEF_rcmax" 
set PARASITIC_FILES(mv_ff_rcmin)	 "$SPEF_rcmin" 
set PARASITIC_FILES(mv_ss_rcmax)	 "$SPEF_rcmax" 
set PARASITIC_FILES(mv_ss_rcmin)	 "$SPEF_rcmin" 
set PARASITIC_FILES(mv_tt_rcnom)	 "$SPEF_rcnom" 
set PARASITIC_FILES(sv_ff_rcmax)	 "$SPEF_rcmax" 
set PARASITIC_FILES(sv_ff_rcmin)	 "$SPEF_rcmin" 
set PARASITIC_FILES(sv_ss_rcmax)	 "$SPEF_rcmax" 
set PARASITIC_FILES(sv_ss_rcmin)	 "$SPEF_rcmin" 
set PARASITIC_FILES(sv_tt_rcnom)	 "$SPEF_rcnom" 
set PARASITIC_FILES(mv_dc_rcnom)	 "$SPEF_rcnom" 

#
# Provide Mode/Corner Specific Derates
#
# The syntax is
#		1. set dmsa_derate_clock_early_value(mode_corner) "_1.09"
#		2. set dmsa_derate_clock_late_value(mode_corner) "_1.09"
#		3. set dmsa_derate_data_early_value(mode_corner) "_1.09"
#		4. set dmsa_derate_data_late_value(mode_corner) "_1.09"

######################################
# Setting Number of Hosts and Licenses
######################################
# Set the number of hosts and licenses to number of dmsa_corners * number of dmsa_modes
set dmsa_num_of_hosts [expr [llength $dmsa_corners] * [llength $dmsa_modes]]
set dmsa_num_of_licenses [expr [llength $dmsa_corners] * [llength $dmsa_modes]]








######################################
# End
######################################

### End of PrimeTime Runtime Variables ###
puts "RM-Info: Completed script [info script]\n"
