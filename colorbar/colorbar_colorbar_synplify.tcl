#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology ECP5UM
set_option -part LFE5UM_85F
set_option -package BG756C
set_option -speed_grade -8

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency 100
set_option -maxfan 1000
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe true
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup 1

set_option -default_enum_encoding default

#simulation options


#timing analysis options
set_option -num_critical_paths 20


#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0



#-- add_file options
set_option -hdl_define -set SBP_SYNTHESIS
set_option -include_path {/home/andy/Downloads/tmp/colorbar_gen}
add_file -verilog {/opt/lscc/diamond/3.11_x64/cae_library/synthesis/verilog/pmi_def.v}
add_file -verilog {/opt/lscc/diamond/3.11_x64/module/reveal/src/ertl/ertl.v}
add_file -verilog {/opt/lscc/diamond/3.11_x64/module/reveal/src/rvl_j2w_module/rvl_j2w_module.v}
add_file -verilog {/opt/lscc/diamond/3.11_x64/module/reveal/src/rvl_j2w_module/wb2sci.v}
add_file -verilog {/opt/lscc/diamond/3.11_x64/module/reveal/src/ertl/JTAG_SOFT.v}
add_file -verilog {/home/andy/Downloads/tmp/colorbar_gen/colorbar/reveal_workspace/tmpreveal/top_la0_trig_gen.v}
add_file -verilog {/home/andy/Downloads/tmp/colorbar_gen/colorbar/reveal_workspace/tmpreveal/top_la0_gen.v}
add_file -verilog {/home/andy/Downloads/tmp/colorbar_gen/colorbar/reveal_workspace/tmpreveal/top_rvl.v}

#-- top module name
set_option -top_module top

#-- set result format/file last
project -result_file {/home/andy/Downloads/tmp/colorbar_gen/colorbar/colorbar_colorbar.edi}

#-- error message log file
project -log_file {colorbar_colorbar.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run
