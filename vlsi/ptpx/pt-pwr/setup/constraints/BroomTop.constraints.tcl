#
source -echo -verbose common.constraints.tcl

# create clocks
source -echo -verbose BroomTop.clock_constraints.tcl

#set_clock_uncertainty -setup $SETUP_UNCERTAINTY [get_clocks *]
#set_clock_uncertainty -hold $HOLD_UNCERTAINTY [get_clocks *]

# [stevo]: make sure synthesis doesn't touch the clock network cells
# but tell ICC to resize them if desired
#if { $SYNTHESIS_CLOCK_CONSTRAINTS } {
#  set_attribute -quiet [get_cells -hierarchical *_cn] dont_touch true
#} else {
#  set_attribute -quiet [get_cells -hierarchical *_cn] size_only true
#}

# Set dt cells as don't touch
set_dont_touch [get_cells -hierarchical *_dt]
set_dont_touch [get_cells -hierarchical IOPAD*]
# Set nets between the IO pads and the chip ports as don't touch, else buffers may be inserted
set_dont_touch [get_flat_nets io_*]

if {$SYNTHESIS_CLOCK_CONSTRAINTS == "true"} {
set_dont_touch [get_nets -segments top/multiClock/tiles_0/core_bist/io_sram_ut_dout*] true
set_dont_touch [get_nets -segments top/multiClock/L2HellaCacheBank/l2_bist/io_sram_ut_dout*] true
  for {set i 0} {$i < 9} {incr i 1} {
    set_dont_touch [get_cells -hierarchical B$i]
    set_dont_touch [get_net -of_object [get_cell -hier B$i] -filter name=~RD*]
  }
} else {
  for {set i 0} {$i < 9} {incr i 1} {
    set_dont_touch [get_flat_cells  *regfile*B$i*]
    set_dont_touch [get_net -of_object [get_flat_cells *regfile*B$i*] -filter name=~RD*]
  }
}


#do we need this?
#set_false_path -from [all_inputs]
#set_false_path -to [all_outputs]

set_ungroup [get_designs ClockTop] false
# Need * because they get uniquified
set_ungroup [get_designs clk_mux_2input*] false
set_ungroup [get_designs clk_mux_4input*] false
set_ungroup [get_designs clk_mux_8input*] false


##Retime FPU and RenameStage
#set PNR_EFFORT high
#set_optimize_registers true -design RenameStage -clock CLK_core_clk_from_fast_clk0 -check_design -verbose -print_critical_loop -justification_effort ${PNR_EFFORT} -minimum_period_only -sync_transform decompose
#set_optimize_registers true -design IntToFP* -clock CLK_core_clk_from_fast_clk0 -check_design -verbose -print_critical_loop -justification_effort ${PNR_EFFORT} -minimum_period_only -sync_transform decompose
#set_optimize_registers true -design FPToFP* -clock CLK_core_clk_from_fast_clk0 -check_design -verbose -print_critical_loop -justification_effort ${PNR_EFFORT} -minimum_period_only -sync_transform decompose
#set_optimize_registers true -design FPUFMAPipe* -clock CLK_core_clk_from_fast_clk0 -check_design -verbose -print_critical_loop -justification_effort ${PNR_EFFORT} -minimum_period_only -sync_transform decompose
#
#ungroup top/multiClock/tiles_0/core/rename_stage -flatten
