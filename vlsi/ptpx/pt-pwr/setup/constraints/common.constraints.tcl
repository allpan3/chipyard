#

if {$synopsys_program_name == "icc_shell"} {
  set SYNTHESIS_CLOCK_CONSTRAINTS false
} else {
  set SYNTHESIS_CLOCK_CONSTRAINTS true
}

# Use corner-appropriate constraints
if {$SYNTHESIS_CLOCK_CONSTRAINTS == "false"} {
  if {[current_scenario] == "SETUP"} {
      source -echo -verbose ss_corner.tcl
  } elseif {[current_scenario] == "HOLD"} {
    source -echo -verbose ff_corner.tcl
  } else {
    echo "Warning: MCMM_CORNER variable appears to be set incorrectly, defaulting to ss corner"
    source -echo -verbose ss_corner.tcl
  }
} else {
  # For synthesis source ss constraints
  source -echo -verbose ss_corner.tcl
}

set SETUP_UNCERTAINTY .05
set HOLD_UNCERTAINTY .1

## Core
#if {$synopsys_program_name == "icc_shell"} {
#  set PERIOD_FAST_CLK0 1
#} else {
#  set PERIOD_FAST_CLK0 0.85
#}
## Uncore
#set PERIOD_FAST_CLK1 1.5 

# cells at top level mess up the UPF domain assignment
set compile_no_new_cells_at_top_level true

# Insert level shifters on clocks that cross voltage boundaries!
set mv_insert_level_shifters_on_ideal_nets all
set auto_insert_level_shifters_on_clocks all

# Synchronous reset
# https://solvnet.synopsys.com/retrieve/017891.html?otSearchResultSrc=advSearch&otSearchResultNumber=7&otPageNum=1
set hdlin_ff_always_sync_set_reset true

#source BroomTop.set_voltage.tcl
