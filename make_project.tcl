# tcl script arguments
set project_name  [lindex $argv 0]
set device_name   [lindex $argv 1]
set report_dir    [lindex $argv 2]
set rtl_dir       [lindex $argv 3]
set constrs_dir   [lindex $argv 4]

# script and root directories
set script_dir    [file normalize [info script]]
set root_dir      [file dirname $script_dir]

# full directories
set full_report_dir   [file join $root_dir $report_dir]
set full_rtl_dir      [file join $root_dir $rtl_dir]
set full_constrs_dir  [file join $root_dir $constrs_dir]

# current project directories
set cur_report_dir    [file join $full_report_dir  $project_name]
set cur_rtl_dir       [file join $full_rtl_dir     $project_name]
set cur_constrs_dir   [file join $full_constrs_dir $project_name]

# verilog and constraint files
set verilog_files    [glob -nocomplain "$cur_rtl_dir/*.v"]
set sdc_files        [glob -nocomplain "$cur_constrs_dir/*.sdc"]
set qsf_files        [glob -nocomplain "$cur_constrs_dir/*.qsf"]

# load required packages
load_package flow
load_package report

# create a new quartus project
project_new $project_name -overwrite -part $device_name

# Add Verilog sources
foreach f $verilog_files {
    set_global_assignment -name VERILOG_FILE $f
}

# Add SDC timing constraints
foreach f $sdc_files {
    set_global_assignment -name SDC_FILE $f
}

# Import any additional .qsf constraint files
foreach f $qsf_files {
    source $f
}

# Set top-level entity
set_global_assignment -name TOP_LEVEL_ENTITY $project_name

# Set report directory
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY $cur_report_dir

# run synthesis
if {[catch { execute_module -tool map } result]} {
    puts "SYNTHESIS FAILED!"
    project_close
    exit 1
}

# run implementation
if {[catch { execute_module -tool fit } result]} {
    puts "IMPLEMENTATION FAILED!"
    project_close
    exit 1
}

# timing analysis
if {[catch { execute_module -tool sta } result]} {
    puts "TIMING FAILED!"
    project_close
    exit 1
}

# power analysis
if {[catch { execute_module -tool pow } result]} {
    puts "POWER ANALYSIS FAILED!"
    project_close
    exit 1
}

# run bitstream generation
if {[catch { execute_module -tool asm } result]} {
    puts "BITSTREAM GENERATION FAILED!"
    project_close
    exit 1
}

# close the project
project_close

exit 0   