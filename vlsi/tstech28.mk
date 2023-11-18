HAMMER_EXEC := ./hammer-nvsa.py
design    ?= hypernora
ENV_YML   ?= $(vlsi_dir)/env-bwrc.yml
TECH_CONF ?= tstech28.yml
# Include the srams used in Verilog source code
HAMMER_EXTRA_ARGS += -p $(vlsi_dir)/tstech28_sram_macros/sram_generator-output.json
VLSI_MODEL_DUT_NAME = chiptop0

EXTRA_SIM_SOURCES="${EXTRA_SIM_SOURCES} +define+UNIT_DELAY"

SIM_PREPROC_DEFINES += "+define+UNIT_DELAY +define+no_warning"

CLOCK_PERIOD = 2.0
USE_SRAM_COMPILER ?= 1

ifeq ($(design),hypernora)
    tech_name         ?= tstech28
    CONFIG            ?= HypernoraConfig
    # DESIGN_CONFS      ?= 
    TOP               ?= ChipTop
    # CUSTOM_VLOG       =
    # TOP_MACROCOMPILER_MODE ?= -l $(SMEMS_CACHE) -hir $(SMEMS_HAMMER) 
endif

ifeq ($(design),hyper)
    tech_name         ?= tstech28
    CONFIG            ?= CustomHPUSoCConfig
    # DESIGN_CONFS      ?= 
    TOP               ?= ChipTop
    # CUSTOM_VLOG       =
    # TOP_MACROCOMPILER_MODE ?= -l $(SMEMS_CACHE) -hir $(SMEMS_HAMMER) 
endif

ifeq ($(design),gemmini)
    tech_name         ?= tstech28
    CONFIG            ?= CustomGemminiSoCConfig
    TOP               ?= ChipTop
endif


ifeq ($(design),boom)
    tech_name         ?= tstech28
    CONFIG            ?= LargeBoomConfig
    TOP               ?= ChipTop
endif

INPUT_CONFS       ?= $(TOOLS_CONF) $(TECH_CONF) $(DESIGN_CONFS)
