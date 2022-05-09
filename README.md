# RISC-V Core Implementation in SystemVerilog
## About
This is my first big SystemVerilog project I did as a school asignment back in 2019. It is a System Verilog implementation of the RV32-IM instruction set.
This implementation features a classic 5-stage pipelined core with the following stages:
- Instruction Fetch Stage
- Instruction Decode Stage
- Execution Stage
- Memory Stage
- Write Back Stage

The implementation has been simulated using Modelsim, but has not been implemented on actual hardware.

## Compiling
C source code can be compiled using the [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) using the following command:

`riscv32-unknown-elf-gcc -march=rv32im -mabi=ilp32 -O0 -nostdlib test.c -o test.o`

After that, the actual machine code and assembly can be outputed through the command:

`riscv32-unknown-elf-objdump -dr test.o`


The **compile** bash script will run these two commands and save the actual machine code as instructions.mem. Then the testbench will read this file into the Instruction Memory. Be careful with the Instruction Addresses though, as the compiler may default to an arbitrary starting address.
