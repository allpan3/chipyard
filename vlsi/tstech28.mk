design    ?= default
ENV_YML   ?= $(vlsi_dir)/env-bwrc.yml
TECH_CONF ?= tstech28.yml

ifeq ($(design),default)
    tech_name         ?= tstech28
    CONFIG            ?= HPURocketConfig
    DESIGN_CONFS      ?= 
    TOP               ?= ChipTop
    # CUSTOM_VLOG       =
    # TOP_MACROCOMPILER_MODE ?= -l $(SMEMS_CACHE) -hir $(SMEMS_HAMMER) 

endif

INPUT_CONFS       ?= $(TOOLS_CONF) $(TECH_CONF) $(DESIGN_CONFS) $(EXTRA_CONFS)