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
set power_analysis_mode averaged

set report_default_significant_digits 4 ;
set sh_source_uses_search_path true ;
# set search_path ". $search_path" ;


##################################################################
#    Netlist Reading Section                                     #
##################################################################

# set link_path "* $link_path"

read_verilog $NETLIST_FILES
# source /bwrcq/C/allpan/chipyard10/vlsi/build/chipyard.harness.TestHarness.LargeBoomConfig-ChipTop/power-rundir/read_file.tcl
current_design $DESIGN_NAME
link > $REPORTS_DIR/$PT_EXEC.link.$REPORTS_SUFFIX.report


##################################################################
#    Power Switching Activity Annotation Section                 #
##################################################################
report_activity_file_check $ACTIVITY_FILE -strip_path $STRIP_PATH \
		> $REPORTS_DIR/$PT_EXEC.activity.$REPORTS_SUFFIX.pre.report

puts $ACTIVITY_FILE
puts $STRIP_PATH
read_saif $ACTIVITY_FILE -strip_path $STRIP_PATH


##################################################################
#    Back Annotation Section                                     #
##################################################################

if {[info exists PARASITIC_PATHS] && [info exists PARASITIC_FILES]} {
  foreach para_path $PARASITIC_PATHS para_file $PARASITIC_FILES {
    if {[string compare $para_path $DESIGN_NAME] == 0} {
      read_parasitics -increment -format SPEF $para_file
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
      source $constraint_file
    }
  }
}

##################################################################
#    Clock Tree Synthesis Section                                #
##################################################################

#set_propagated_clock [all_clocks]


##################################################################
#    Update_timing and check_timing Section                      #
##################################################################

#update_timing -full

# Ensure design is properly constrained
#check_timing -verbose > $REPORTS_DIR/$PT_EXEC.ct.$REPORTS_SUFFIX.report


##################################################################
#    Report_timing Section                                       #
##################################################################

#report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -sign 4 > $REPORTS_DIR/$PT_EXEC.timing.$REPORTS_SUFFIX.report
#report_clock -skew -attribute > $REPORTS_DIR/$PT_EXEC.clock.$REPORTS_SUFFIX.report
#report_analysis_coverage > $REPORTS_DIR/$PT_EXEC.converage.$REPORTS_SUFFIX.report


##################################################################
#    Power Analysis Section                                      #
##################################################################
## run power analysis
check_power > $REPORTS_DIR/$PT_EXEC.checkpower.$REPORTS_SUFFIX.report
update_power > $REPORTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX.update.report

report_switching_activity -list_not_annotated > $REPORTS_DIR/$PT_EXEC.switching.$REPORTS_SUFFIX.post.report


#  report_power         # Display power report
#    [-net_power]           (Report power for nets)
#    [-cell_power]          (Report power for cells)
#    [-include_lib_cells]   (Report library cell names along with cell names)
#    [-threshold_voltage_group]
#                           (Report threshold voltage group for cells)
#    [-lvth_groups <low_vth_group_list>]
#                           (List of low vth groups)
#    [-leaf]                (Report leaf-level cells or nets)
#    [-include_boundary_nets]
#                           (Include primary input port nets)
#    [-verbose]             (Verbose power reporting)
#    [-nworst <number>]     (Max number of nets or cells to report: 
#                            Value >= 0)
#    [-sort_by <sort_method>]
#                           (Sort cells/nets by sort_method: 
#                            Values: name, cell_leakage_power, 
#                            cell_internal_power, net_switching_power, 
#                            dynamic_power, net_toggle_rate, 
#                            total_net_load, total_power, 
#                            net_static_probability)
#    [-nosplit]             (Do not split lines when fields overflow)
#    [-hierarchy]           (Report power consumption hierarchically)
#    [-levels <number>]     (Number of levels of hierarchy to be reported: 
#                            Value >= 1)
#    [-power_greater_than <threshold>]
#                           (Report power only for values no less than <threshold>)
#    [-clocks <clock_list>] (Report power only for objects related to these clocks)
#    [-groups <group_list>] (Report power only for objects in these power groups)
#    [-include_estimated_clock_network]
#                           (Include power from estimated clock network)
#    [-derate]              (Report power derate)
#    [-rails <rails/power supply nets name list>]
#                           (Report power only for the specified rails/power supply nets)
#    [-pattern_priority <pattern_priority_list>]
#                           (list of library cell name pattern)
#    [-attribute string]    (attribute name to retrieve user defined pattern name for a library cell)
#    [-significant_digits <number>]
#                           (Report power for specified significant digit: 
#                            Range: 0 to 13)
#    [-pst]                 (Report power for valid power state combinations)
#    [-relative_toggle_rate]
#                           (report relative toggle rate of nets)
#    [object_list]          (Report power only for these cells or nets)

report_power -nosplit -verbose -hierarchy > $REPORTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX.report
# report_power -nosplit -verbose -hierarchy -power_greater_than 0.1 > $REPORTS_DIR/$PT_EXEC.power.filter.$REPORTS_SUFFIX.report
report_power -nosplit -verbose -hierarchy -leaf > $REPORTS_DIR/$PT_EXEC.power.leaf.$REPORTS_SUFFIX.report
# report_power -nosplit -verbose -hierarchy -levels 5 > $REPORTS_DIR/$PT_EXEC.power.level.$REPORTS_SUFFIX.report
# Group-based power report
report_power -nosplit -verbose > $REPORTS_DIR/$PT_EXEC.power.grp.$REPORTS_SUFFIX.rpt


report_clock_gate_savings  > $REPORTS_DIR/$PT_EXEC.clock-gate-savings.rpt

exit
