design := hypernora

ifeq ($(design),hypernora)
CONFIG := HypernoraSmallConfig
endif

ifeq ($(design),boom)
CONFIG := LargeBoomConfig
endif

ifeq ($(design),rocket)
CONFIG := RocketConfig
endif

$(info Running CONFIG=$(CONFIG) BINARY=$(BINARY))

dramsim = 1
BINARY := /bwrcq/C/allpan/chipyard10/generators/hpu/build/baremetal/test.riscv
# /bwrcq/C/allpan/chipyard10/generators/hpu/build/mc-mnist/conv.riscv
#cycle
dump_start ?= 1000000
#ns
saif_start_time := 0
saif_end_time   := `bc <<< $(saif_start_time)+1000000`
# `bc <<< $(timeout_cycles)*$(CLOCK_PERIOD)`

# HAMMER_EXTRA_ARGS += -p $(vlsi_dir)/tstech28_sram_macros/sram_generator-output.json

TOP_DIR := $(abspath ../..)
# TECH_CONF := $(TOP_DIR)/vlsi/tstech28.yml
OBJ_DIR = $(TOP_DIR)/vlsi/build/chipyard.harness.TestHarness.$(CONFIG)-ChipTop
GEN_DIR = $(TOP_DIR)/vlsi/generated-src/chipyard.harness.TestHarness.$(CONFIG)
OUT_DIR = $(TOP_DIR)/vlsi/output/chipyard.harness.TestHarness.$(CONFIG)
syn_dir = $(OBJ_DIR)/syn-rundir
sim_rtl_dir := $(OBJ_DIR)/sim-rtl-rundir
sim_syn_dir := $(OBJ_DIR)/sim-syn-rundir
# TestDriver = /bwrcq/C/allpan/chipyard10/generators/rocket-chip/src/main/resources/vsrc/TestDriver.v
dramsim_dir = /bwrcq/C/allpan/chipyard10/generators/testchipip/src/main/resources/dramsim2_ini
CLOCK_PERIOD = 2.0
timeout_cycles = 30000000
SIM_CONF = $(OBJ_DIR)/sim-inputs.yml
SIM_DEBUG_CONF = $(OBJ_DIR)/sim-debug-inputs.yml
DESIGN_NAME = ChipTop 
TB_NAME = TestHarness
FILE_LIST = $(OBJ_DIR)/sim_syn_files.f
HAMMER_EXEC ?= /bwrcq/C/allpan/chipyard10/vlsi/hammer-nvsa.py
PT_SETUP_HOME = $(PWD)/pt-pwr

ifdef dramsim
dramsim := +dramsim +dramsim_ini_dir=$(dramsim_dir)
endif

get_out_name = $(subst $() $(),_,$(notdir $(basename $(1))))
binary_file = $(notdir $(BINARY))
vcd_name = $(call get_out_name,$(BINARY))
vcd_name_path = $(OUT_DIR)/$(vcd_name).vpd
get_waveform_flag=+vcdplusfile=$(1)
# get_waveform_flag=+vcdfile=$(1)

HAMMER_EXTRA_ARGS += -p /bwrcq/C/allpan/chipyard10/vlsi/example-tools.yml -p /bwrcq/C/allpan/chipyard10/vlsi/tstech28.yml
# -p /bwrcq/C/allpan/chipyard10/vlsi/tstech28_sram_macros/sram_generator-output.json

SIM_FLAGS = -notice -line +lint=all,noVCDE,noONGS,noUI,noNS,noSVA-UA,noSVA-DIU,noSVA-NSVU,noSVA-CE,noVNGS,noPCTIO-L,noVNGS,noIWU \
            -error=PCWM-L -error=noZMMCM -timescale=1ns/10ps -quiet -q +rad +vcs+lic+wait +vc+list -sverilog +systemverilogext+.sv+.svi+.svh+.svt -assert svaext +libext+.sv +v2k \
			+verilog2001ext+.v95+.vt+.vp +libext+.v -debug_pp +incdir+$(GEN_DIR)/gen-collateral

DEFINES = CLOCK_PERIOD=$(CLOCK_PERIOD) RESET_DELAY=777.7 PRINTF_COND=TestDriver.printf_cond STOP_COND=!TestDriver.reset MODEL=TestHarness RANDOMIZE_MEM_INIT RANDOMIZE_REG_INIT RANDOMIZE_GARBAGE_ASSIGN RANDOMIZE_INVALID_ASSIGN \
          UNIT_DELAY # no_warning


.PHONY: $(SIM_CONF) $(SIM_DEBUG_CONF)
$(SIM_CONF):
	mkdir -p $(dir $@)
	echo "sim.inputs:" > $@
	echo "  top_module: ChipTop" >> $@
	echo "  tb_name: ''" >> $@  # don't specify -top
	echo "  input_files:" >> $@
	for x in $$(cat $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).model.f | sort -u) $(GEN_DIR)/gen-collateral/chipyard.harness.TestHarness.$(CONFIG).model.mems.v $(TOP_DIR)/generators/rocket-chip/src/main/resources/vsrc/TestDriver.v; do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  input_files_meta: 'append'" >> $@
	echo "  timescale: '1ns/10ps'" >> $@
	echo "  options:" >> $@
	for x in $(SIM_FLAGS); do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  options_meta: 'append'" >> $@
	echo "  defines:" >> $@
	for x in $(DEFINES); do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  defines_meta: 'append'" >> $@
	echo "  compiler_cc_opts:" >> $@
	for x in -O3 -std=c++17 -I$(TOP_DIR)/.conda-env/riscv-tools/include -I$(TOP_DIR)/tools/DRAMSim2 -I$(GEN_DIR)/gen-collateral; do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  compiler_cc_opts_meta: 'append'" >> $@
	echo "  compiler_ld_opts:" >> $@
	for x in -L$(TOP_DIR)/.conda-env/riscv-tools/lib -Wl,-rpath,$(TOP_DIR)/.conda-env/riscv-tools/lib -L$(TOP_DIR)/vlsi -L$(TOP_DIR)/tools/DRAMSim2 -lriscv -lfesvr -ldramsim; do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  compiler_ld_opts_meta: 'append'" >> $@
	echo "  execution_flags_prepend: ['+permissive']" >> $@
	echo "  execution_flags_append: ['+permissive-off']" >> $@
	echo "  execution_flags:" >> $@
	for x in +dramsim +dramsim_ini_dir=$(TOP_DIR)/generators/testchipip/src/main/resources/dramsim2_ini +max-cycles=$(timeout_cycles); do \
	echo '    - "'$$x'"' >> $@; \
	done
	echo "  execution_flags_meta: 'append'" >> $@
	echo "  benchmarks: ['$(BINARY)']" >> $@
	echo "  tb_dut: 'TestDriver.testHarness.chiptop0'" >> $@

$(SIM_DEBUG_CONF):
	mkdir -p $(dir $@)
	mkdir -p $(OUT_DIR)
	echo "sim.inputs:" > $@
	echo "  defines: ['DEBUG']" >> $@
	echo "  defines_meta: 'append'" >> $@
	echo "  execution_flags:" >> $@
	for x in +verbose $(call get_waveform_flag,$(vcd_name_path)); do \
		echo '    - "'$$x'"' >> $@; \
	done
	echo "  execution_flags_meta: 'append'" >> $@
	echo "  saif.mode: 'time'" >> $@
	echo "  saif.start_time: '$(saif_start_time)ns'" >> $@
	echo "  saif.end_time: '$(saif_end_time)ns'" >> $@
	echo "sim.outputs.waveforms: ['$(vcd_name_path)']" >> $@

syn-to-sim: $(OBJ_DIR)/sim-syn-input.json
	touch $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).model.mems.v
# $(TOP_DIR)/scripts/split-mems-conf.py \
# 		--in-smems-conf $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).mems.conf \
# 		--in-model-hrchy-json $(GEN_DIR)/model_module_hierarchy.uniquified.json \
# 		--dut-module-name ChipTop \
# 		--model-module-name TestHarness \
# 		--out-dut-smems-conf $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).top.mems.conf \
# 		--out-model-smems-conf $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).model.mems.conf
# cd $(TOP_DIR) && java -cp $(TOP_DIR)/.classpath_cache/tapeout.jar barstools.macros.MacroCompiler  -n $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).model.mems.conf -v $(GEN_DIR)/gen-collateral/chipyard.harness.TestHarness.$(CONFIG).model.mems.v -f $(GEN_DIR)/chipyard.harness.TestHarness.$(CONFIG).model.mems.fir --mode synflops
	
# $(OBJ_DIR)/sim-%/sim-output-full.json: private override HAMMER_EXTRA_ARGS += $(HAMMER_SIM_EXTRA_ARGS)

$(OBJ_DIR)/sim-syn-input.json: $(syn_dir)/syn-output-full.json
	$(HAMMER_EXEC) -e $(TOP_DIR)/vlsi/env-bwrc.yml -p $(syn_dir)/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o $(OBJ_DIR)/sim-syn-input.json --obj_dir $(OBJ_DIR) syn-to-sim

$(sim_syn_dir)/sim-output-full.json: $(OBJ_DIR)/sim-syn-input.json $(HAMMER_SIM_SYN_DEPENDENCIES)

build-sim-rtl: $(SIM_CONF)
build-sim-rtl: override HAMMER_EXTRA_ARGS += -p $(OBJ_DIR)/inputs.yml -p $(SIM_CONF) -p $(OBJ_DIR)/sram_generator-output.json
build-sim-rtl:
	$(HAMMER_EXEC) -e $(TOP_DIR)/vlsi/env-bwrc.yml $(HAMMER_EXTRA_ARGS) --sim_rundir $(OBJ_DIR)/sim-rtl-rundir --obj_dir $(OBJ_DIR) sim

build-sim-rtl-debug: $(SIM_CONF) $(SIM_DEBUG_CONF)
build-sim-rtl-debug: override HAMMER_EXTRA_ARGS += -p $(OBJ_DIR)/inputs.yml -p $(SIM_DEBUG_CONF) -p $(SIM_CONF) -p $(OBJ_DIR)/sram_generator-output.json
build-sim-rtl-debug:
	$(HAMMER_EXEC) -e $(TOP_DIR)/vlsi/env-bwrc.yml $(HAMMER_EXTRA_ARGS) --sim_rundir $(OBJ_DIR)/sim-rtl-rundir --obj_dir $(OBJ_DIR) sim

build-sim-syn: $(SIM_CONF) $(sim_syn_dir)/sim-output-full.json
build-sim-syn: override HAMMER_EXTRA_ARGS += -p $(SIM_CONF)
build-sim-syn:
	$(HAMMER_EXEC) -e $(TOP_DIR)/vlsi/env-bwrc.yml -p $(OBJ_DIR)/sim-syn-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir $(OBJ_DIR)/sim-syn-rundir --obj_dir $(OBJ_DIR) sim

build-sim-syn-debug: $(SIM_CONF) $(SIM_DEBUG_CONF)
build-sim-syn-debug: override HAMMER_EXTRA_ARGS += -p $(SIM_DEBUG_CONF) -p $(SIM_CONF)
build-sim-syn-debug:
	$(HAMMER_EXEC) -e $(TOP_DIR)/vlsi/env-bwrc.yml -p $(OBJ_DIR)/sim-syn-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir $(OBJ_DIR)/sim-syn-rundir --obj_dir $(OBJ_DIR) sim

run-sim-rtl:
	(set -o pipefail && \
	$(sim_rtl_dir)/simv +permissive $(dramsim) +max-cycles=$(timeout_cycles) +permissive-off $(BINARY) | tee $(OBJ_DIR)/sim-rtl-rundir/$(binary_file)/$(vcd_name).log)

run-sim-rtl-debug: $(sim_rtl_dir)/$(binary_file)/run.tcl
	mkdir -p $(sim_rtl_dir)/$(binary_file) && \
	cd $(sim_rtl_dir)/$(binary_file) && \
	$(sim_rtl_dir)/simv +permissive +verbose +ntb_random_seed_automatic $(call get_waveform_flag,$(vcd_name_path)) $(dramsim) +max-cycles=$(timeout_cycles) +dump-start=$(dump_start) -saif_opt+toggle_start_at_set_region+toggle_stop_at_toggle_report -ucli2Proc -ucli -do $(sim_rtl_dir)/run.tcl +permissive-off $(BINARY) </dev/null | tee $(OBJ_DIR)/sim-rtl-rundir/$(binary_file)/$(vcd_name).log
# $(sim_rtl_dir)/simv +permissive +verbose +ntb_random_seed_automatic $(call get_waveform_flag,$(vcd_name_path)) $(dramsim) +max-cycles=$(timeout_cycles) +dump-start=$(dump_start) -saif_opt+toggle_start_at_set_region+toggle_stop_at_toggle_report -ucli2Proc -ucli -do run.tcl +permissive-off $(BINARY) </dev/null | tee $(OBJ_DIR)/sim-rtl-rundir/$(binary_file)/$(vcd_name).log

run-sim-syn:
	set -o pipefail && \
	$(sim_syn_dir)/simv +permissive $(dramsim) +max-cycles=$(timeout_cycles) -ucli -do $(sim_syn_dir)/run.tcl +permissive-off $(BINARY) | tee $(OBJ_DIR)/sim-syn-rundir/$(vcd_name).log

run-sim-syn-debug: $(sim_syn_dir)/$(binary_file)/run.tcl
	cd $(sim_syn_dir)/$(binary_file) && \
	$(sim_syn_dir)/simv +permissive +verbose +ntb_random_seed_automatic $(call get_waveform_flag,$(vcd_name_path)) $(dramsim) +max-cycles=$(timeout_cycles) +dump-start=$(dump_start) -saif_opt+toggle_start_at_set_region+toggle_stop_at_toggle_report -ucli2Proc -ucli -do run.tcl +permissive-off $(BINARY) </dev/null | tee $(OBJ_DIR)/sim-syn-rundir/$(binary_file)/$(vcd_name).log
# mv $(sim_syn_dir)/$(binary_file)/ucli.saif $(sim_syn_dir)/$(binary_file)/$(vcd_name).saif 

%/run.tcl: 
	mkdir -p $*
# cp $(sim_syn_dir)/run.tcl $(sim_syn_dir)/$(binary_file)/run.tcl
	cp $(dir $*)run.tcl $@


include ./pt-pwr/Makefrag

.PHONY: power-rtl-avg
power-rtl-avg: 
power-rtl-avg: $(pt_avg_max_rpt)

.PHONY: power-syn-avg
power-syn-avg: $(pt_avg_max_rpt)

.PHONY: power-syn-time
power-syn-time: $(pt_time_max_rpt)

# .PHONY: power-syn
# power-syn: $(pt_avg_max_rpt) $(pt_time_max_rpt)
