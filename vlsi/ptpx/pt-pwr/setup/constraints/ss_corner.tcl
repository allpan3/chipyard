if {$SYNTHESIS_CLOCK_CONSTRAINTS == "false"} {
  set DC_DERATE 1.0
} else {
  set DC_DERATE 0.9
}

# Core
set PERIOD_FAST_CLK0 1
# BIST
set PERIOD_FAST_CLK1 2

set PERIOD_FAST_CLK0 [expr $PERIOD_FAST_CLK0*$DC_DERATE]
set PERIOD_FAST_CLK1 [expr $PERIOD_FAST_CLK1*$DC_DERATE]

#Do we need this?
#group_path -name CLK_core_clk_from_fast_clk0 -weight 8 -critical 0.4
#group_path -name CLK_l2_clk_from_fast_clk2 -weight 2 -critical 0.4

#set_clock_latency 0.5 [get_clocks *]
#set_clock_latency 0.0 [get_pins -of_objects [get_cells -hier *latch -filter "clock_gating_integrated_cell=~*"] -filter "name == CP"]
#set_clock_latency 0.5 [get_pins -of_objects [get_cells -of_objects */*DF*] -filter "name == CP"]

if {$SYNTHESIS_CLOCK_CONSTRAINTS == "false"} {
  set_voltage -object VDDCORE 0.81
  set_voltage -object VDDPST 1.62
  set_voltage -object VDD 0.81
  set_voltage -object VSS 0.0
  set_voltage -object AVDD 0.81
}
