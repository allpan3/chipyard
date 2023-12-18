# Core
set PERIOD_FAST_CLK0 1.0
# BIST
set PERIOD_FAST_CLK1 1.5 
# Uncore
set PERIOD_SLOW_CLK 1.3
set PERIOD_SLOW_CLK_TINY 5.0

set SYNTHESIS_CLOCK_CONSTRAINTS false

source clocks.tcl

set_clock_uncertainty -setup 0.05 [get_clocks *]
set_clock_uncertainty -hold 0.1 [get_clocks *]

set_voltage -object VDDCORE 0.9
set_voltage -object VDDSRAM 0.9
set_voltage -object VDDPST 1.62
set_voltage -object VDD 0.9
set_voltage -object VSS 0.0
set_voltage -object AVDD 0.9
