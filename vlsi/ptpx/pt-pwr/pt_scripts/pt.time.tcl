#################################################################################
# PrimeTime Reference Methodology Script
# Script: pt.tcl
# Version: D-2010.06 (July 6, 2010)
# Copyright (C) 2008-2010 Synopsys All rights reserved.
################################################################################

##################################################################
#    Source common and pt_setup.tcl File                         #
##################################################################

source make_generated_vars.tcl
source common_setup.tcl
source pt_setup.tcl

set REPORTS_SUFFIX $PT_METHOD.$PT_PARASITIC


##################################################################
#    Search Path, Library and Operating Condition Section        #
##################################################################

# Under normal circumstances, when executing a script with source, Tcl
# errors (syntax and semantic) cause the execution of the script to terminate.
# Uncomment the following line to set sh_continue_on_error to true to allow
# processing to continue when errors occur.
#set sh_continue_on_error true

set power_enable_analysis true
set power_analysis_mode time_based

set report_default_significant_digits 4 ;
set sh_source_uses_search_path true ;
# set search_path ". $search_path" ;


##################################################################
#    Netlist Reading Section                                     #
##################################################################

# set link_path "* $link_path"

read_verilog $NETLIST_FILES
current_design $DESIGN_NAME
link > $REPORTS_DIR/$PT_EXEC.link.$REPORTS_SUFFIX.report


##################################################################
#    Power Switching Activity Annotation Section                 #
##################################################################
puts $ACTIVITY_FILE
puts $STRIP_PATH
read_vcd $ACTIVITY_FILE -strip_path $STRIP_PATH -zero_delay


##################################################################
#    Back Annotation Section                                     #
##################################################################

if {[info exists PARASITIC_PATHS] && [info exists PARASITIC_FILES]} {
  foreach para_path $PARASITIC_PATHS para_file $PARASITIC_FILES {
    if {[string compare $para_path $DESIGN_NAME] == 0} {
      read_parasitics -increment -format sbpf $para_file
    } else {
      read_parasitics -path $para_path -increment -format sbpf $para_file
    }
  }
  report_annotated_parasitics -check > $REPORTS_DIR/$PT_EXEC.rap.$REPORTS_SUFFIX.report
}


##################################################################
#    Reading Constraints Section                                 #
##################################################################

if {[info exists CONSTRAINT_FILES]} {
  foreach constraint_file $CONSTRAINT_FILES {
    if {[file extension $constraint_file] eq ".sdc"} {
      read_sdc $constraint_file -version 2.0
    } else {
      source -echo $constraint_file
    }
  }
}

##################################################################
#    Clock Tree Synthesis Section                                #
##################################################################
# set_propagated_clock [all_clocks]


##################################################################
#    Update_timing and check_timing Section                      #
##################################################################

# update_timing -full

## Ensure design is properly constrained
# check_timing -verbose > $REPORTS_DIR/$PT_EXEC.ct.$REPORTS_SUFFIX.report


##################################################################
#    Report_timing Section                                       #
##################################################################

# report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -sign 4 > $REPORTS_DIR/$PT_EXEC.timing.$REPORTS_SUFFIX.report
# report_clock -skew -attribute > $REPORTS_DIR/$PT_EXEC.clock.$REPORTS_SUFFIX.report
# report_analysis_coverage > $REPORTS_DIR/$PT_EXEC.converage.$REPORTS_SUFFIX.report


##################################################################
#    Power Analysis Section                                      #
##################################################################

## run power analysis
check_power > $REPORTS_DIR/$PT_EXEC.checkpower.$REPORTS_SUFFIX.report

set_power_analysis_options -include all_with_leaf \
                           -waveform_output $RESULTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX \
                           -waveform_interval 5.0
                          #  -waveform_format out

#  set_power_analysis_options # Set options for the power analysis mode
#    [-static_leakage_only] (Only compute leakage, skip dynamic power computations)
#    [-through_mode]        (Enables pass through propagation of toggle rates in clock network)
#    [-waveform_interval <float>]
#                           (Specify the sampling interval)
#    [-cycle_accurate_cycle_count <integer>]
#                           (The number of clock cycles used as the sampling interval in CAPP: 
#                            Value >= 0)
#    [-cycle_accurate_clock clock]
#                           (Base Clock used for CAPP analysis)
#    [-waveform_format fsdb|out|none]
#                           (Output file format, default: fsdb: 
#                            Values: fsdb, out, none)
#    [-waveform_output file]
#                           (File prefix of power waveform file)
#    [-include top|all_without_leaf|all_with_leaf]
#                           (Select the part of design to be analyzed: 
#                            Values: top, all_without_leaf, all_with_leaf)
#    [-include_groups list] (The power groups to be analyzed)
#    [-cells list]          (Only cells specified to be analyzed)
#    [-sdpd_tracking enabled|disabled]
#                           (Enable or disable SDPD tracking in time_based and averaged power analysis)
#    [-sdpd_tracking_cells list]
#                           (The list of cells to be tracked for SDPD analysis)
#    [-multi_rail_waveform list]
#                           (The list of supply nets )
#    [-separate_power_waveform leakage | all]
#                           (leakage or all in time_based power analysis )
#    [-conflict_activity_cells list]
#                           (The list of cells which have conflict activities)
#    [-exclude_arc_scaling_libcells list]
#                           (The list of lib cells not to be scale internal arc)
#    [-npeak <integer>]     (The number of peak power to be reported: 
#                            Value >= 0)
#    [-npeak_out file]      (File prefix of npeak report)

# set_power_analysis_options 	-include all_without_leaf \
# 							-npeak 10 -peak_power_instances \
# 							-npeak_out $ptpx_reports_dir/$ptpx_design_name \
# 							-waveform_output $ptpx_reports_dir/$ptpx_design_name

# set_power_analysis_options -waveform_format out -waveform_output vcd
update_power > $REPORTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX.update.report
## report_power
report_power -nosplit -verbose -hierarchy > $REPORTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX.report
report_power -nosplit -verbose -hierarchy -leaf > $REPORTS_DIR/$PT_EXEC.power.leaf.$REPORTS_SUFFIX.report
# report_power -nosplit -verbose -hierarchy -power_greater_than 0.1 > $REPORTS_DIR/$PT_EXEC.power.filter.$REPORTS_SUFFIX.report


exit
