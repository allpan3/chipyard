multivoltage ?= 0
effort ?= low

tt := tt0p9v25c
ss := ss0p81v125c
ff := ff0p99vm40c
mv_dc = ss0p81v125c
vt := lvt
vtu := LVT

input_delay = 0
output_delay = 0

clock_period = 2
vcs_clock_period = 0$(shell echo "scale=4; ${clock_period}*1.0" | bc)
dc_clock_period = 0$(shell echo "scale=4; ${clock_period}*1.0" | bc)

clock_uncertainty = 0$(shell echo "scale=4; ${clock_period}*0.05" | bc)
input_delay = 0$(shell echo "scale=4; ${clock_period}*0.2" | bc)
output_delay = 0$(shell echo "scale=4; ${clock_period}*0.2" | bc)


###### Begin TSMC ##########
TSMC_HOME = /tools/tstech28/TSMCHOME/digital
techfile_dir = $(TSMC_HOME)/Back_End/milkyway/tcbn28hpmbwp35hvt_120a
tluplus_dir = $(vlsi_dir)/tluplus
techfile = techfiles/HVH_0d5_0/tsmcn28_10lm7X2ZUTRDL.tf
mapfile = gdsout_7X2Z.map

filler_cells = FILL64BWP35$(vtu) FILL32BWP35$(vtu) FILL16BWP35$(vtu) FILL8BWP35$(vtu) FILL4BWP35$(vtu) FILL3BWP35$(vtu) FILL2BWP35$(vtu)
io_filler_cells = PFILLER5_G PFILLER20_G PFILLER1_G PFILLER10_G PFILLER05_G PFILLER0005_G
io_analog_filler_cells = PFILLER5A_G PFILLER20A_G PFILLER1A_G PFILLER10A_G PFILLER05A_G PFILLER0005A_G
decap_cells = DCAP64BWP35$(vtu) DCAP32BWP35$(vtu) DCAP16BWP35$(vtu) DCAP8BWP35$(vtu) DCAP4BWP35$(vtu)
physical_only_cell = DCAP16BWP35$(vtu) DCAP32BWP35$(vtu) DCAP4BWP35$(vtu) DCAP64BWP35$(vtu) DCAP8BWP35$(vtu) PVDD1DGZ_V_G PVDD2DGZ_V_G PVSS1DGZ_V_G PVSS2DGZ_V_G PVSS2AC_V_G PVSS3AC_V_G PVDD3AC_V_G PVDD2POC_V_G

tsmc_sram_dir = /bwrcq/C/allpan/chipyard10/vlsi/tstech28_sram_macros

tsmc_srams = $(shell find $(tsmc_sram_dir) -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

srams_db_dir = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/NLDM) 
srams_lef_dir = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/LEF) 
srams_v_dir = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/VERILOG)
srams_tt_db = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/NLDM/$(sram)_$(tt).db)
srams_ff_db = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/NLDM/$(sram)_$(ff).db)
srams_ss_db = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/NLDM/$(sram)_$(ss).db)
srams_mw_dir = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/LEF/$(sram)) 
srams_gds = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/GDSII/$(sram)_m5h.gds) 
srams_v = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/VERILOG/$(sram)_$(tt).v) 
#srams_lef = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/LEF/$(sram).lef) 
srams_cdl = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/SPICE/$(sram).spi)
srams_hcell = $(foreach sram, $(tsmc_srams), $(tsmc_sram_dir)/$(sram)/SPICE/$(sram).hcell)

# Setup corners (including SRAM+cells)
# TODO: Add MCMM
SRAMS_sv_ss = $(foreach sram, $(tsmc_srams), $(sram)_$(ss).db)
LIBS_sv_ss = tcbn28hpmbwp35$(ss)_ccs.db tcbn28hpmbwp35ss0p81v0p81v125c_ccs.db tcbn28hpmbwp35$(vt)$(ss)_ccs.db tcbn28hpmbwp35$(vt)ss0p81v0p81v125c_ccs.db $(SRAMS_sv_ss) 
OPCONDLIBS_sv_ss = tcbn28hpmbwp35$(vt)$(ss)_ccs.db
VDDCORE_sv_ss = 0.81
VDDUNCORE_sv_ss = 0.81

SRAMS_sv_ff = $(foreach sram, $(tsmc_srams), $(sram)_$(ff).db)
LIBS_sv_ff = tcbn28hpmbwp35$(ff)_ccs.db tcbn28hpmbwp35ff0p99v0p99vm40c_ccs.db tcbn28hpmbwp35$(vt)$(ff)_ccs.db tcbn28hpmbwp35$(vt)ff0p99v0p99vm40c_ccs.db $(SRAMS_sv_ff)
OPCONDLIBS_sv_ff = tcbn28hpmbwp35$(vt)$(ff)_ccs.db
VDDCORE_sv_ff = 0.99
VDDUNCORE_sv_ff = 0.99

SRAMS_sv_tt = $(foreach sram, $(tsmc_srams), $(sram)_$(sv_tt).db)
LIBS_sv_tt = tcbn28hpmbwp35$(vt)$(tt)_ccs.db tcbn28hpmbwp35$(vt)$(tt)_ccs.db $(SRAMS_sv_tt) 
OPCONDLIBS_sv_tt = tcbn28hpmbwp35$(vt)tt0p9v25c_ccs.db
VDDCORE_sv_tt = 0.9
VDDUNCORE_sv_tt = 0.9

# Need cross corner for synthesis
SRAMS_mv_dc = $(foreach sram, $(tsmc_srams), $(sram)_$(mv_dc).db)
# Order matters: need 0p81v0p9v first (low to high first, because low->high definied in both, and the correct one is in the lowvoltage_highvoltage library
LIBS_mv_dc = tcbn28hpmbwp35$(vt)ss0p81v0p9v125c_ccs.db tcbn28hpmbwp35$(vt)ss0p9v0p81v125c_ccs.db $(SRAMS_mv_dc) 
OPCONDLIBS_mv_dc = tcbn28hpmbwp35ss0p81v125c_ccs.db
VDDCORE_mv_dc = 0.81
VDDUNCORE_mv_dc = 0.9

LIBS_mv_ff = tcbn28hpmbwp35$(vt)ff0p99v1p05vm40c_ccs.db tcbn28hpmbwp35$(vt)ff0p88v0p99vm40c_ccs.db tcbn28hpmbwp35$(vt)ff0p99v0p88vm40c_ccs.db tcbn28hpmbwp35$(vt)ff1p05v0p99vm40c_ccs.db

#Standard cells
cells_v_dir = $(TSMC_HOME)/Front_End/verilog/tcbn28hpmbwp35$(vt)_120a
cells_v = $(cells_v_dir)/tcbn28hpmbwp35$(vt).v $(TSMC_HOME)/Front_End/verilog/tcbn28hpmbwp35_120a/tcbn28hpmbwp35.v $(TSMC_HOME)/Front_End/verilog/tcbn28hpmbwp35hvt_120a/tcbn28hpmbwp35hvt.v
#cells_v = $(TSMC_HOME)/Front_End/verilog/tcbn28hpmbwp35hvt_120a/tcbn28hpmbwp35hvt.v
cells_ccs_db_dir = $(TSMC_HOME)/Front_End/timing_power_noise/CCS/tcbn28hpmbwp35_120a $(TSMC_HOME)/Front_End/timing_power_noise/CCS/tcbn28hpmbwp35lvt_120a $(TSMC_HOME)/Front_End/timing_power_noise/CCS/tcbn28hpmbwp35hvt_120a
#cells_ccs_db_dir = $(TSMC_HOME)/Front_End/timing_power_noise/CCS/tcbn28hpmbwp35hvt_120a
cells_ccs_ss_db = tcbn28hpmbwp35$(ss)_ccs.db tcbn28hpmbwp35lvt$(ss)_ccs.db tcbn28hpmbwp35hvt$(ss)_ccs.db
#cells_ccs_ss_db = tcbn28hpmbwp35hvt$(ss)_ccs.db
cells_ccs_ff_db = tcbn28hpmbwp35$(ff)_ccs.db tcbn28hpmbwp35lvt$(ff)_ccs.db tcbn28hpmbwp35hvt$(ff)_ccs.db
cells_ccs_tt_db = tcbn28hpmbwp35$(tt)_ccs.db tcbn28hpmbwp35lvt$(tt)_ccs.db tcbn28hpmbwp35hvt$(tt)_ccs.db

cells_cdl = $(TSMC_HOME)/Back_End/spice/tcbn28hpmbwp35hvt_120a/tcbn28hpmbwp35hvt_120a.spi
cells_gds = $(TSMC_HOME)/Back_End/gds/tcbn28hpmbwp35hvt_120a/tcbn28hpmbwp35hvt.gds
#cells_mw_dir = $(TSMC_HOME)/Back_End/milkyway/tcbn28hpmbwp35hvt_120a/cell_frame_HVH_0d5_0/tcbn28hpmbwp35hvt
cells_mw_dir = $(TSMC_HOME)/Back_End/milkyway/tcbn28hpmbwp35_120a/cell_frame_HVH_0d5_0/tcbn28hpmbwp35 $(TSMC_HOME)/Back_End/milkyway/tcbn28hpmbwp35lvt_120a/cell_frame_HVH_0d5_0/tcbn28hpmbwp35lvt $(TSMC_HOME)/Back_End/milkyway/tcbn28hpmbwp35hvt_120a/cell_frame_HVH_0d5_0/tcbn28hpmbwp35hvt

#Multi-voltage domain
cells_ccs_mv1_db = tcbn28hpmbwp35ss0p9v0p81v125c_ccs.db tcbn28hpmbwp35lvtss0p9v0p81v125c_ccs.db tcbn28hpmbwp35hvtss0p9v0p81v125c_ccs.db
cells_ccs_mv2_db = tcbn28hpmbwp35ss0p81v0p9v125c_ccs.db tcbn28hpmbwp35lvtss0p81v0p9v125c_ccs.db tcbn28hpmbwp35hvtss0p81v0p9v125c_ccs.db
cells_ccs_mv3_db = tcbn28hpmbwp35ss0p9v0p9v125c_ccs.db tcbn28hpmbwp35lvtss0p9v0p9v125c_ccs.db tcbn28hpmbwp35hvtss0p9v0p9v125c_ccs.db
cells_ccs_mv4_db = tcbn28hpmbwp35ss0p81v0p81v125c_ccs.db tcbn28hpmbwp35lvtss0p81v0p81v125c_ccs.db tcbn28hpmbwp35hvtss0p81v0p81v125c_ccs.db


###IO Library
io_v_dir = $(TSMC_HOME)/Front_End/verilog/tphn28hpmgv18_120a
ios_v = $(io_v_dir)/tphn28hpmgv18.v 
io_db_dir = $(TSMC_HOME)/Front_End/timing_power_noise/NLDM/tphn28hpmgv18_120a
io_ss_db = tphn28hpmgv18ss0p81v1p62v125c.db
io_tt_db = tphn28hpmgv18tt0p9v1p8v25c.db
io_ff_db = tphn28hpmgv18ff0p99v1p98vm40c.db
io_gds = $(TSMC_HOME)/Back_End/gds/tphn28hpmgv18_120a/mt_2/10lm/tphn28hpmgv18.gds
io_cdl = $(TSMC_HOME)/Back_End/spice/tphn28hpmgv18_120a/tphn28hpmgv18.spi
io_mw_dir = $(TSMC_HOME)/Back_End/milkyway/tphn28hpmgv18_120a/mt_2/10lm/cell_frame/tphn28hpmgv18

pad_mw_dir = $(TSMC_HOME)/Back_End/milkyway/tpbn28v_140a/cup/10m/10M_7X2Z/cell_frame/tpbn28v
pad_gds = $(TSMC_HOME)/Back_End/gds/tpbn28v_140a/cup/10m/10M_7X2Z/tpbn28v.gds

## Clock receiver files
# clkrx_dir = $(base_dir)/swerve-clock-receiver
# clkrx_db_dir = $(clkrx_dir)/NLDM
# clkrx_tt_db = clkrx_$(tt).db
# clkrx_ss_db = clkrx_$(ss).db
# clkrx_ff_db = clkrx_$(ff).db
# clkrx_v_dir = $(clkrx_dir)/VERILOG
# clkrx_v = $(clkrx_v_dir)/clkrx.v
# clkrx_mw_dir = $(clkrx_dir)/LEF/clkrx
# clkrx_cdl = $(clkrx_dir)/SPICE/clkrx.cdl
# clkrx_gds = $(clkrx_dir)/GDSII/clkrx.gds
# clkrx_lef = $(clkrx_dir)/LEF/clkrx.lef

#For LVS
source_cdl = /tools/tstech28/packages/T-N28-CL-LS-002-C1_1.0.3o/source.added
