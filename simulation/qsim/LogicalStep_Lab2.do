onerror {exit -code 1}
vlib work
vlog -work work LogicalStep_Lab2_top.vo
vlog -work work Logic_Processor_Simulation.vwf.vt
vsim -novopt -c -t 1ps -L fiftyfivenm_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.LogicalStep_Lab2_top_vlg_vec_tst -voptargs="+acc"
vcd file -direction LogicalStep_Lab2.msim.vcd
vcd add -internal LogicalStep_Lab2_top_vlg_vec_tst/*
vcd add -internal LogicalStep_Lab2_top_vlg_vec_tst/i1/*
run -all
quit -f
