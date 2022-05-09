quit -sim

vlib work

vlog "../rtl/*.sv"
vlog "../testbench/*.sv"

vsim RiscVTestbench

do wave.do

set RunLength 20ns
