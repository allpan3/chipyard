design    ?= default
ENV_YML   ?= $(vlsi_dir)/env-bwrc.yml
TECH_CONF ?= tstech28.yml
# Include the srams used in Verilog source code
HAMMER_EXTRA_ARGS += -p $(vlsi_dir)/tstech28_sram_macros/sram_generator-output.json

CLOCK_PERIOD = 2.0
USE_SRAM_COMPILER ?= 1

ifeq ($(design),default)
    tech_name         ?= tstech28
    CONFIG            ?= HPURocketConfig
    # DESIGN_CONFS      ?= 
    TOP               ?= ChipTop
    # CUSTOM_VLOG       =
    # TOP_MACROCOMPILER_MODE ?= -l $(SMEMS_CACHE) -hir $(SMEMS_HAMMER) 
endif

INPUT_CONFS       ?= $(TOOLS_CONF) $(TECH_CONF) $(DESIGN_CONFS)