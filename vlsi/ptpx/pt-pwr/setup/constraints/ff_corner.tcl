if {$SYNTHESIS_CLOCK_CONSTRAINTS == "false"} {
  set DC_DERATE 1.0
} else {
  set DC_DERATE 0.9
}

# Core
set PERIOD_FAST_CLK0 0.9
# BIST
set PERIOD_FAST_CLK1 1.3 

set PERIOD_FAST_CLK0 [expr $PERIOD_FAST_CLK0*$DC_DERATE]
set PERIOD_FAST_CLK1 [expr $PERIOD_FAST_CLK1*$DC_DERATE]



if {$SYNTHESIS_CLOCK_CONSTRAINTS == "false"} {
  set_voltage -object VDDCORE 0.99
  set_voltage -object VDDPST 1.62
  set_voltage -object VDD 0.99
  set_voltage -object VSS 0.0
  set_voltage -object AVDD 0.99
}
