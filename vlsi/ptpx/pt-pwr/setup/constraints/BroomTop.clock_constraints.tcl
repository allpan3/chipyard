#-----------------------------------------------------------------------------
# Set Units
#-----------------------------------------------------------------------------
set_units -capacitance pF
set_units -time ns

#-----------------------------------------------------------------------------
# Clock Definitions
#-----------------------------------------------------------------------------

set timing_enable_multiple_clocks_per_reg true

set CLKMUXES {top/clocktop/rocket_clk_mux top/clocktop/system_clk_mux }
set DIVIDERS {top/clocktop/fast_clk0_divide_dt top/clocktop/fast_clk1_divide_dt }
set CLKMUX_INPUTS [get_pins -of_objects $CLKMUXES -filter "name=~D*"]
set DIVIDER_INPUTS [get_pins -of_objects $DIVIDERS -filter "name=~CP*"]
set ALL_EXCEPTION_PINS [add_to_collection $CLKMUX_INPUTS $DIVIDER_INPUTS]

# Define clock locations
set CLKPORT_fast_clk0 [get_pins top/clocktop/clkin_buffer_fast_clk0_dt/out ]
set CLKPORT_fast_clk1 [get_pins top/clocktop/clkin_buffer_fast_clk1_dt/out ]
set CLKPORT_slow_clk [get_pins pad_frame/IOPAD_*slow_clk_*/C ]

# Dividers
set CLKPORT_fast_clk0_div2 [get_pins top/clocktop/fast_clk0_divide_dt/Q ]
set CLKPORT_fast_clk0_div2_in [get_pins top/clocktop/fast_clk0_divide_dt/CP]
set CLKPORT_fast_clk1_div2 [get_pins top/clocktop/fast_clk1_divide_dt/Q ]
set CLKPORT_fast_clk1_div2_in [get_pins top/clocktop/fast_clk1_divide_dt/CP]

# Mux outputs
set CLKPORT_core_clk [get_pins top/clocktop/rocket_clk_mux/finalmux/finalmux_dt/Z]
set CLKPORT_core_clk_from_fast_clk0 [get_pins top/clocktop/rocket_clk_mux/D1]
set CLKMUX_inputs_except_core [remove_from_collection $ALL_EXCEPTION_PINS [get_pins top/clocktop/rocket_clk_mux/D1]]
set CLKPORT_system_clk [get_pins top/clocktop/system_clk_mux/finalmux/finalmux_dt/Z]
set CLKPORT_system_clk_from_fast_clk1 [get_pins top/clocktop/system_clk_mux/D2]
set CLKMUX_inputs_except_system [remove_from_collection $ALL_EXCEPTION_PINS [get_pins top/clocktop/system_clk_mux/D2]]

#set_dont_touch fast_clk0_analog true
#set_dont_touch fast_clk1_analog true

# create_clock should only be used on signals coming from an IP boundary
# These are all of the original clock sources

# Uncore original source
#create_clock -name "CLK_slow_clk" -period $PERIOD_SLOW_CLK $CLKPORT_slow_clk

# Core original source
create_clock -name "CLK_fast_clk0" -period $PERIOD_FAST_CLK0 $CLKPORT_fast_clk0 

# BIST original source
create_clock -name "CLK_fast_clk1" -period $PERIOD_FAST_CLK1 $CLKPORT_fast_clk1 


# We definitely need a generated_clock on the outout of a divide
create_generated_clock -name "CLK_fast_clk0_div2" -divide_by 2 -source $CLKPORT_fast_clk0 $CLKPORT_fast_clk0_div2 -master CLK_fast_clk0
create_generated_clock -name "CLK_fast_clk1_div2" -divide_by 2 -source $CLKPORT_fast_clk1 $CLKPORT_fast_clk1_div2 -master CLK_fast_clk1

# Don't set -source at the root, otherwise the divided signal will get through as well
# Instead, take it directly from the input to the mux

# Uncore clock tree: Start from fast_clk0 (defined in -master), and again, exclude balancing through other muxes
#create_generated_clock -name "CLK_uncore_clk_from_slow_clk" -combinational -source $CLKPORT_uncore_clk_from_slow_clk $CLKPORT_uncore_clk -master CLK_slow_clk
#if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
#set_clock_tree_exceptions -clocks {CLK_slow_clk} -exclude_pins $CLKMUX_inputs_except_uncore
#}

# Core: fast_clk0
create_generated_clock -name "CLK_core_clk_from_fast_clk0" -combinational -source $CLKPORT_core_clk_from_fast_clk0 $CLKPORT_core_clk -master CLK_fast_clk0
if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
set_clock_tree_exceptions -clocks {CLK_fast_clk0} -exclude_pins $CLKMUX_inputs_except_core
}

create_generated_clock -name "CLK_system_clk_from_fast_clk1" -combinational -source $CLKPORT_system_clk_from_fast_clk1 $CLKPORT_system_clk -master CLK_fast_clk1
if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
set_clock_tree_exceptions -clocks {CLK_fast_clk1} -exclude_pins $CLKMUX_inputs_except_system
}


## Core BIST: fast_clk1
#create_generated_clock -name "CLK_corebist_clk_from_fast_clk1" -combinational -source $CLKPORT_corebist_clk_from_fast_clk1 $CLKPORT_corebist_clk -master CLK_fast_clk1
#if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
#set_clock_tree_exceptions -clocks {CLK_fast_clk1} -exclude_pins $CLKMUX_inputs_except_corebist
#}
#
## L2 BIST: fast_clk1 (shared)
#create_generated_clock -name "CLK_l2bist_clk_from_fast_clk1" -combinational -source $CLKPORT_l2bist_clk_from_fast_clk1 $CLKPORT_l2bist_clk -master CLK_fast_clk1_clone
#if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
#set_clock_tree_exceptions -clocks {CLK_fast_clk1_clone} -exclude_pins $CLKMUX_inputs_except_l2bist
#}

# Should be any paths, but don't let it try...
#set_false_path -from CLK_corebist_clk_from_fast_clk1 -to CLK_l2bist_clk_from_fast_clk1
#set_false_path -from CLK_l2bist_clk_from_fast_clk1 -to CLK_corebist_clk_from_fast_clk1

## L2: fast_clk2
#create_generated_clock -name "CLK_l2_clk_from_fast_clk2" -combinational -source $CLKPORT_l2_clk_from_fast_clk2 $CLKPORT_l2_clk -master_clock CLK_fast_clk2
#if !$SYNTHESIS_CLOCK_CONSTRAINTS then {
#set_clock_tree_exceptions -clocks {CLK_fast_clk2} -exclude_pins $CLKMUX_inputs_except_l2
#}

# For each group, include the master and all of its generated clocks
# Think about where the sinks are
set_clock_groups -asynchronous \
  -group { CLK_fast_clk0 CLK_fast_clk0_div2 CLK_core_clk_from_fast_clk0} \
  -group { CLK_fast_clk1 CLK_fast_clk1_div2 CLK_system_clk_from_fast_clk1 } \
 

#set DESIGN_CLOCKS {CLK_slow_clk CLK_fast_clk0 CLK_fast_clk1 CLK_fast_clk2}
 #foreach CLK_FROM $DESIGN_CLOCKS {
  #set_false_path -from $CLK_FROM -to [remove_from_collection [all_clocks] $CLK_FROM]
 #}

# Don't time the select signals
set_false_path -from [get_pins top/clocktop/clkout_rocket_0_sel*]
if {$SYNTHESIS_CLOCK_CONSTRAINTS == "true"} {
  set_disable_timing [get_pins -of_object [get_cell -hier *sram_dout_latch*] -filter name=~in*]
  set_disable_timing [get_cell -hier error_log_out*]
} else {
  set_disable_timing [get_pins -of_object [get_flat_cell *sram_dout_latch*reg*] -filter name=~D]
  set_disable_timing [get_pins -of_objects [get_cell -hier error_log_out*] -filter name=~D]
  set_disable_timing [get_pins -of_objects [get_flat_cells *dpath*sram_ut_dout_registered*reg*] -filter name=~CP]
  set_disable_timing [get_pin -of_object [get_flat_cell *error_log_out*reg*] -filter name=~E]
  set_false_path -to [get_pins -of_object [get_flat_cell *sram_dout_latch*reg*] -filter name=~D]
  set_false_path -to [get_pins -of_objects [get_cell -hier error_log_out*] -filter name=~D]
  set_false_path -from [get_pins -of_objects [get_flat_cells *dpath*sram_ut_dout_registered*reg*] -filter name=~CP]
  set_false_path -to [get_pin -of_object [get_flat_cell *error_log_out*reg*] -filter name=~E]
}
#-----------------------------------------------------------------------------
# Pin Constraints
#-----------------------------------------------------------------------------

set_input_transition 1 [remove_from_collection [all_inputs] [get_ports io_clkin_*]]
#set_input_delay 0 -clock CLK_uncore_clk_from_slow_clk [get_ports IO_io_host_in_bits*]
