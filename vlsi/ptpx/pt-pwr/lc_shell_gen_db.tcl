set sram_macros_dir /bwrcq/C/allpan/chipyard10/vlsi/tstech28_sram_macros

# All SRAM macros
set sram_macros [exec find $sram_macros_dir -maxdepth 1 -mindepth 1 -type d]

set sram_lib_list [glob $sram_macros_dir/*/NLDM/*.lib]

set sh_source_uses_search_path true ;
set search_path ". $ADDITIONAL_SEARCH_PATH $search_path"

set sram_db_list ""

foreach sram_lib_name $sram_lib_list {
    read_lib $sram_lib_name
    set sram_name [file rootname $sram_lib_name]
    lappend sram_db_list [concat ${sram_name}.db]
}

set libs ""
foreach_in_collection sram_lib [get_libs] {
    lappend libs [get_object_name $sram_lib]
}

for {set i 0} {$i < [llength $libs]} {incr i 1} {
    set sram_lib_name [lindex $libs $i]
    write_lib $sram_lib_name -format db -output [lindex $sram_db_list $i]
}

exit