#source -echo -verbose make_generated_vars.tcl
#source -echo -verbose common_setup.tcl
#source -echo -verbose dc_setup_filenames.tcl
source make_generated_vars.tcl
source common_setup.tcl
source dc_setup_filenames.tcl

#################################################################################
# Design Compiler Top-Down Reference Methodology Setup
# Script: dc_setup.tcl
# Version: D-2010.03-SP1 (May 24, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
#################################################################################

# RIMAS
# disable annoying messages
# technology file related warnings (benign)
suppress_message TFCHK-012
suppress_message TFCHK-049
suppress_message TFCHK-050
suppress_message TFCHK-080
suppress_message TFCHK-089
# SRAM MW lib warning
suppress_message MWLIBP-311
# Warning: layerNumber 73 does not exist or is out of range. (MWLIBP-311)
suppress_message PWR-536
# Information: The library cell 'PMT3_HVT' in the library 'saed32hvt_tt1p05v25c' is not characterized for internal power. (PWR-536)

suppress_message UID-401
suppress_message RCEX-011

# no preferred routing direction...
suppress_message DCT-035
# core area, i/o pin location not specified
suppress_message DCT-041
suppress_message DCT-042

# Chisel
#Warning:  /tools/designs/Dcdg/users/bmzimmer/swerve/vlsi/generated-src/Top.DefaultVLSIConfig.v:50884: signed to unsigned assignment occurs. (VER-318)
suppress_message VER-318
#Warning:  /tools/designs/Dcdg/users/bmzimmer/swerve/vlsi/generated-src/Top.DefaultVLSIConfig.v:88029: Case statement can not be optimized using boolean optimization, because its branch number(277) is greater than the max number of branches. You can change the public variable hdlin_optimize_pla_max_branch setting for using boolean optimization, but runtime and QoR may be hit. (ELAB-496)
#set hdlin_optimize_pla_max_branch 512
set hdlin_optimize_pla_max_branch 5120

# TSMC
#Warning: ContactCode 'CONT1' is missing the attribute 'unitMinResistance'. (line 1840) (TFCHK-014)
suppress_message TFCHK-014
#Warning: Inconsistent Number Of Metal Layers:
	#11 (Main Library) <==> 10 (Reference Library). (MWLIBP-301)
suppress_message MWLIBP-301
#Warning: Inconsistent Number Of Metal Layers:
	#11 (Main Library) <==> 10 (Reference Library). (MWLIBP-301)
#Warning: Inconsistent Data for Contact Code 48
	#Main Library (SWERVETop_LIB)      |	Reference Library (tphn28hpmgv18)
	#Lower Layer     M7 (30, 0)        |	M7 (0, 30)
	#Upper Layer     M8 (0, 30)        |	M8 (30, 0)	 (MWLIBP-324)

#Warning: Inconsistent Data for Contact Code 48
	#Main Library (SWERVETop_LIB)      |	Reference Library (tphn28hpmgv18)
	#Lower Layer     M7 (30, 0)        |	M7 (0, 30)
	#Upper Layer     M8 (0, 30)        |	M8 (30, 0)	 (MWLIBP-324)
suppress_message MWLIBP-324
#Warning: CapModel sections are missing. Capacitance models should be loaded with a TLU+ file later. (TFCHK-084)
suppress_message TFCHK-084
#Warning: Reference Library Inconsistent With Main Library
#Reference Library: /tools/tstech28/IP/tphn28hpmgv18_100a/TSMCHOME/digital/Back_End/milkyway/tphn28hpmgv18_100a/mt_2/10lm/cell_frame/tphn28hpmgv18 (MWLIBP-300)
suppress_message MWLIBP-300
#Error: missing data found. Please refer to LIBCHK-212.  (LIBCHK-101)
#Warning: List of pins missing in logic library (LIBCHK-212)
#------------------------------------------------------------------------------
#Physical library           Cell name             Pin name    Pin direction
#------------------------------------------------------------------------------
#tphn28hpmgv18              PRCUT_G               POC         Input/Output
                                                 #VDDPST      Input/Output
                                                 #VSSPST      Input/Output
#------------------------------------------------------------------------------
suppress_message LIBCHK-212
set suppress_errors  [concat suppress_errors  [list LIBCHK-101]]

#Warning: Cell 'PRCUT_G', The cell should have at least 1 primary_ground pg_pin and at least 1 primary_power pg_pin. (LBDB-909)
suppress_message LBDB-909


# Portions of dc_setup.tcl may be used by other tools so do check for DC only commands
if {$synopsys_program_name == "dc_shell"}  {
  # Use the set_host_options command to enable multicore optimization to improve runtime.
  # This feature has special usage and license requirements.  Refer to the 
  # "Support for Multicore Technology" section in the Design Compiler User Guide
  # for multicore usage guidelines.
  # Note: This is a DC Ultra feature and is not supported in DC Expert.

  set_host_options -max_cores 12
  # Change alib_library_analysis_path to point to a central cache of analyzed libraries
  # to save some runtime and disk space.  The following setting only reflects the
  # the default value and should be changed to a central location for best results.
  set_app_var alib_library_analysis_path ${ALIB_DIR}
}

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}

#################################################################################
# Library Setup
#
# This section is designed to work with the settings from common_setup.tcl
# without any additional modification.
#################################################################################

# Define all the library variables shared by all the front-end tools

set_app_var search_path ". ${ADDITIONAL_SEARCH_PATH} $search_path"

# Milkyway variable settings
# Make sure to define the following Milkyway library variables
# mw_logic1_net, mw_logic0_net and mw_design_library are needed by write_milkyway

set_app_var mw_logic1_net ${MW_POWER_NET}
set_app_var mw_logic0_net ${MW_GROUND_NET}

set mw_reference_library ${MW_REFERENCE_LIB_DIRS}
set mw_design_library ${DCRM_MW_LIBRARY_NAME}

set mw_site_name_mapping [list CORE unit Core unit core unit]

# The remainder of the setup below should only be performed in Design Compiler
if {$synopsys_program_name == "dc_shell"}  {

  # Include all libraries for multi-Vth leakage power optimization
  echo "set_app_var target_library ${TARGET_LIBRARY_FILES}"
  set_app_var target_library ${TARGET_LIBRARY_FILES}
  set_app_var synthetic_library dw_foundation.sldb
  set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"

  # Set min libraries if they exist
  echo MIN_LIBRARY_FILES = $MIN_LIBRARY_FILES
  foreach {max_library min_library} $MIN_LIBRARY_FILES {
    echo "set_min_library $max_library -min_version $min_library"
    set_min_library $max_library -min_version $min_library
  }

  if {[shell_is_in_topographical_mode]} {
    # Only create new Milkyway design library if it doesn't already exist
    if {![file isdirectory $mw_design_library ]} {
      create_mw_lib   -technology $TECH_FILE \
                      -mw_reference_library $mw_reference_library \
                      $mw_design_library
    } else {
      # If Milkyway design library already exists, ensure that it is consistent with specified Milkyway reference libraries
      set_mw_lib_reference $mw_design_library -mw_reference_library $mw_reference_library
    }

    open_mw_lib     $mw_design_library
    check_library

    #set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE \
                       #-min_tluplus $TLUPLUS_MIN_FILE \
                       #-tech2itf_map $MAP_FILE

    set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE \
                       -min_tluplus $TLUPLUS_MIN_FILE 

    check_tlu_plus_files
  }

  #################################################################################
  # Library Modifications
  #
  # Apply library modifications here after the libraries are loaded.
  #################################################################################

  if {[file exists [which ${LIBRARY_DONT_USE_FILE}]]} {
    source -echo -verbose ${LIBRARY_DONT_USE_FILE}
  }


}

