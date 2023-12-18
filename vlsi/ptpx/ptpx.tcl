


set ptpx_design_name  $::env(DESIGN_NAME)
set ptpx_gl_netlist  $::env(FILE_LIST)
set ptpx_logs_dir  $::env(PTPX_BUILDDIR)
set ptpx_strip_path         		$::env(saif_instance)

set ptpx_analysis_mode				$::env(analysis_mode)
set ptpx_zero_delay_simulation		$::env(zero_delay_simulation)
set ptpx_op_condition				$::env(lib_op_condition)


#=========================================================================
# setup-session.tcl
#=========================================================================
# The setup session script configures the PrimteTime session to use
# PT PX or PrimePower to do power analysis

# Set up paths and libraries
set_app_var search_path      ". $ptpx_additional_search_path $search_path"
set_app_var target_library   $ptpx_target_libraries
set_app_var link_library     [join "
                               *
                               $ptpx_target_libraries
                               $ptpx_extra_link_libraries
                             "]

# check if requireed activity file exist

if {$ptpx_analysis_mode == "time_based"} {
	if {[file exists $ptpx_vcd] == 0} {
		echo "Error: Did not find a value change dump file for time-based power analysis!"
    	exit 1
	} 
} elseif {$ptpx_analysis_mode == "averaged"} {
	if {[file exists $ptpx_saif] == 1} {
		set ptpx_averaged_use_activity "saif"
	} elseif { [file exists $ptpx_vcd] == 1 } {
		set ptpx_averaged_use_activity "vcd"
	} else {
		echo "Error: Did not find a VCD or SAIF file for averaged power analysis!"
    	exit 1
	}

} else {
	echo "Error: analysis_mode must be set either averaged or time_based!"
	exit 1
}

#=========================================================================
# read-design.tcl
#=========================================================================
read_verilog $ptpx_gl_netlist
current_design $ptpx_design_name

link_design > ${ptpx_logs_dir}/${ptpx_design_name}.link.rpt

# Namemapping for RTL switching activities
if { $ptpx_rtl_mapping == True } {
	echo "Sourcing RTL name mapping file for RTL switching activity annotation."
	source $ptpx_namemap -echo > ${ptpx_logs_dir}/${ptpx_design_name}.namemap.rpt
}

