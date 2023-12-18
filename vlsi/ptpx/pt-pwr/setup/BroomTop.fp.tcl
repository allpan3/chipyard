###################################################################

# Created by write_floorplan on Thu Aug 10 00:26:24 2017

###################################################################
undo_config -disable

remove_die_area 

create_die_area  \
	-poly {	{0.000 0.000} {1879.880 0.000} {1879.880 2879.600} {0.000 2879.600} {0.000 0.000}} 
set oldSnapState [set_object_snap_type -enabled false]

#**************
# Hard Macro 
# obj#: 73 
# objects are in alphabetical ordering 
#**************


set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 185.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 373.690}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram10"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 562.380}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram11"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 751.070}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram12"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 939.760}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram13"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 1128.450}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram14"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 1317.140}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram15"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 1505.830}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram16"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 185.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram17"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 373.690}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram18"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 562.380}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram19"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 751.070}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram2"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 562.380}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram20"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 939.760}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram21"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 1128.450}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram22"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 1317.140}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram23"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 1505.830}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram24"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 185.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram25"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 373.690}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram26"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 562.380}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram27"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 751.070}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram28"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 939.760}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram29"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 1128.450}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram3"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 751.070}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram30"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 1317.140}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram31"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 1505.830}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram4"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 939.760}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram5"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 1128.450}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram6"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 1317.140}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram7"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 1505.830}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram8"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 185.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram9"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 373.690}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/lrt_array_lrt_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1125.755 1751.610}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1514.190 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram1"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1125.755 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram2"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {754.125 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram3"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {365.690 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram10"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1132.755 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram11"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1521.190 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram12"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {358.690 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram13"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {747.125 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram14"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram15"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram2"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1132.755 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram3"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1521.190 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram4"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {358.690 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram5"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {747.125 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram6"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1340.445 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram7"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 1694.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram8"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram9"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {539.435 1855.835}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/data_L1D_data_array_1_L1D_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 2335.570}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/data_L1D_data_array_2_L1D_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {258.345 2532.085}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/data_L1D_data_array_3_L1D_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {258.345 2335.570}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/data_L1D_data_array_L1D_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {151.000 2532.085}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/meta/L1D_tag_array_L1D_tag_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {432.180 2538.685}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/HellaCache/meta/L1D_tag_array_L1D_tag_array_ext_sram1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {365.690 2538.685}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/bpd_counters_h_table_h_table_smem_smem_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1440.700 2560.150}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/bpd_counters_p_table_p_table_0_smem_smem_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1406.065 2560.150}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/bpd_counters_p_table_p_table_1_smem_smem_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1343.795 2560.150}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/btb_btb_data_array_1_btb_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1336.795 2606.550}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/btb_btb_data_array_btb_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1283.165 2606.550}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/btb_btb_tag_array_1_btb_tag_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1222.535 2662.230}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/core/bpd_stage/btb_btb_tag_array_btb_tag_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1276.165 2662.230}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_bb_array_L1I_bb_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1485.830 2493.970}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_data_array_1_L1I_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 2335.570}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_data_array_2_L1I_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1521.190 2532.085}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_data_array_3_L1I_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1521.190 2335.570}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_data_array_L1I_data_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1728.880 2532.085}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_tag_array_L1I_tag_array_ext_sram0"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1514.190 2569.485}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"top/multiClock_tiles_0/icache_icache/L1I_tag_array_L1I_tag_array_ext_sram1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1447.700 2569.485}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

#************************
#  Placement Blockage  
# obj#: 1 
# objects are in positional ordering 
#************************

remove_placement_blockage *


create_placement_blockage  \
	-type hard \
	-name clkrx_blk \
	-coordinate {{876.000 151.800} {1021.400 201.000}} 

#******************
#  Voltage Area  
# obj#: 1 
# objects are in positional ordering 
#******************


remove_voltage_area -all

create_voltage_area -power_domain PD_CORE \
	-color 255 \
	-guard_band_x 0 \
	-guard_band_y 0 \
	-coordinate {  {{151.000 2017.150} {1728.880 2728.600}} } 

remove_bounds -all



set_object_snap_type -enabled $oldSnapState
undo_config -enable

# Keepout margins added by write_fp procedure:
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

set_keepout_margin -tracks_per_macro_pin 0.500000 -min_padding_per_macro 0.000000 -max_padding_per_macro -1.000000
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5600 4.0500} [get_cells {top/multiClock_tiles_0/core/bpd_stage/btb_btb_data_array_btb_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5600 3.5000 3.5000 4.0500} [get_cells {top/multiClock_tiles_0/core/bpd_stage/btb_btb_data_array_1_btb_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.6950 3.5000 3.5000 3.5500} [get_cells {top/multiClock_tiles_0/core/bpd_stage/bpd_counters_p_table_p_table_0_smem_smem_ext_sram0}]
set_keepout_margin -type hard -outer {3.6950 3.5000 3.5000 3.5500} [get_cells {top/multiClock_tiles_0/core/bpd_stage/bpd_counters_h_table_h_table_smem_smem_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6950 3.5500} [get_cells {top/multiClock_tiles_0/core/bpd_stage/bpd_counters_p_table_p_table_1_smem_smem_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6100 3.6850} [get_cells {top/multiClock_tiles_0/HellaCache/meta/L1D_tag_array_L1D_tag_array_ext_sram1}]
set_keepout_margin -type hard -outer {3.6100 3.5000 3.5000 3.6850} [get_cells {top/multiClock_tiles_0/HellaCache/meta/L1D_tag_array_L1D_tag_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5600 3.5000 3.5000 3.9300} [get_cells {top/multiClock_tiles_0/core/bpd_stage/btb_btb_tag_array_btb_tag_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5600 3.9300} [get_cells {top/multiClock_tiles_0/core/bpd_stage/btb_btb_tag_array_1_btb_tag_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/HellaCache/data_L1D_data_array_L1D_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/HellaCache/data_L1D_data_array_1_L1D_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/HellaCache/data_L1D_data_array_2_L1D_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/HellaCache/data_L1D_data_array_3_L1D_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.2850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_data_array_L1I_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.2850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_data_array_1_L1I_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_data_array_2_L1I_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.2850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_data_array_3_L1I_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6100 3.8850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_tag_array_L1I_tag_array_ext_sram1}]
set_keepout_margin -type hard -outer {3.6100 3.5000 3.5000 3.8850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_tag_array_L1I_tag_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.7800 3.7850} [get_cells {top/multiClock_tiles_0/icache_icache/L1I_bb_array_L1I_bb_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6950 4.2100} [get_cells {top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram3}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6950 4.2100} [get_cells {top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram2}]
set_keepout_margin -type hard -outer {3.6950 3.5000 3.5000 4.2100} [get_cells {top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram1}]
set_keepout_margin -type hard -outer {3.6950 3.5000 3.5000 4.2100} [get_cells {top/multiClock_L2HellaCacheBank_data/recycle_array_recycle_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.8050 3.5000 3.5000 4.2850} [get_cells {top/multiClock_L2HellaCacheBank_data/lrt_array_lrt_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram31}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram30}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram29}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram28}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram27}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram26}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram25}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram24}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram23}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram22}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram21}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram20}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram19}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram18}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram17}]
set_keepout_margin -type hard -outer {3.5300 3.5000 3.5000 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram16}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram15}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram14}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram13}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram12}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram11}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram10}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram9}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram8}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram7}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram6}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram5}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram4}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram3}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram2}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram1}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.5300 4.0100} [get_cells {top/multiClock_L2HellaCacheBank_data/L2Bank_data_array_L2Bank_data_array_ext_sram0}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.7850 4.3400} [get_cells {top/clocktop/clkin_buffer_fast_clk0_dt}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.6550 4.3400} [get_cells {top/clocktop/clkin_buffer_fast_clk1_dt}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram15}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram14}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram13}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram12}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram11}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram10}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram9}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram8}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram7}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram6}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram5}]
set_keepout_margin -type hard -outer {3.8850 3.5000 3.5000 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram4}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram3}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram2}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram1}]
set_keepout_margin -type hard -outer {3.5000 3.5000 3.8850 4.3850} [get_cells {top/multiClock_L2HellaCacheBank_meta/meta_L2Bank_tag_array_L2Bank_tag_array_ext_sram0}]

set_object_snap_type -enabled $oldSnapState
undo_config -enable
