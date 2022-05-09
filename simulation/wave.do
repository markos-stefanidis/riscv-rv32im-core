onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group CLOCKS -color White /RiscVTestbench/RiscV/Clk
add wave -noupdate -group CLOCKS -color Gray90 /RiscVTestbench/RiscV/Rst
add wave -noupdate -group IF -group {PC REG} /RiscVTestbench/RiscV/PC_Reg/Next_PC
add wave -noupdate -group IF -group {PC REG} /RiscVTestbench/RiscV/PC_Reg/FIFO_Stall
add wave -noupdate -group IF -group {PC REG} /RiscVTestbench/RiscV/PC_Reg/Hazard_Stall
add wave -noupdate -group IF -group {PC REG} /RiscVTestbench/RiscV/PC_Reg/Curr_PC
add wave -noupdate -group IF -radix hexadecimal /RiscVTestbench/RiscV/Instruction
add wave -noupdate -group ID -group {REGISTER FILE} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Reg_Write
add wave -noupdate -group ID -group {REGISTER FILE} -color {Dark Orchid} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Rs_Address_1
add wave -noupdate -group ID -group {REGISTER FILE} -color {Dark Orchid} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Rs_Address_2
add wave -noupdate -group ID -group {REGISTER FILE} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Wr_Address
add wave -noupdate -group ID -group {REGISTER FILE} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Wr_Data
add wave -noupdate -group ID -group {REGISTER FILE} -color {Dark Orchid} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Rs_Data_1
add wave -noupdate -group ID -group {REGISTER FILE} -color {Dark Orchid} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/Rs_Data_2
add wave -noupdate -group ID -group {REGISTER FILE} -radix hexadecimal /RiscVTestbench/RiscV/Register_File/index
add wave -noupdate -group ID -group {REGISTER FILE} -radix hexadecimal -childformat {{{/RiscVTestbench/RiscV/Register_File/Reg_File[0]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[1]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[2]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[3]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[4]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[5]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[6]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[7]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[8]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[9]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[10]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[11]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[12]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[13]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[14]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[15]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[16]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[17]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[18]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[19]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[20]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[21]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[22]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[23]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[24]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[25]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[26]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[27]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[28]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[29]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[30]} -radix hexadecimal} {{/RiscVTestbench/RiscV/Register_File/Reg_File[31]} -radix hexadecimal}} -expand -subitemconfig {{/RiscVTestbench/RiscV/Register_File/Reg_File[0]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[1]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[2]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[3]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[4]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[5]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[6]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[7]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[8]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[9]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[10]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[11]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[12]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[13]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[14]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[15]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[16]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[17]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[18]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[19]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[20]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[21]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[22]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[23]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[24]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[25]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[26]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[27]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[28]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[29]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[30]} {-height 18 -radix hexadecimal} {/RiscVTestbench/RiscV/Register_File/Reg_File[31]} {-height 18 -radix hexadecimal}} /RiscVTestbench/RiscV/Register_File/Reg_File
add wave -noupdate -group ID -group {HAZARD DETECTION} -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/IF_ID_RS_1
add wave -noupdate -group ID -group {HAZARD DETECTION} -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/IF_ID_RS_2
add wave -noupdate -group ID -group {HAZARD DETECTION} -color Gold -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/ID_EX_RD
add wave -noupdate -group ID -group {HAZARD DETECTION} -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/ID_EX_MEM_READ
add wave -noupdate -group ID -group {HAZARD DETECTION} -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/ID_EX_CSR_READ
add wave -noupdate -group ID -group {HAZARD DETECTION} -radix hexadecimal /RiscVTestbench/RiscV/Hazard_Detection/Stall
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Instruction
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Branch
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Mem_Read
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Mem_Write
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/ALU_Op
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Reg_Write
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Mem_to_Reg
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/ALU_Src
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/JALR
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/JAL
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/CSR_Sel
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Reg_Src
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/R_Type
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/R_Type_I
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/CSR
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/LUI
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/AUIPC
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/LW
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/SW
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/JAL_opcode
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/JALR_opcode
add wave -noupdate -group ID -group {CONTROL UNIT} /RiscVTestbench/RiscV/Control_Unit/Branch_opcode
add wave -noupdate -group EX -radix hexadecimal /RiscVTestbench/RiscV/B.Rs_Data_1
add wave -noupdate -group EX -radix hexadecimal /RiscVTestbench/RiscV/B.Rs_Data_2
add wave -noupdate -group EX -group ALU -radix hexadecimal /RiscVTestbench/RiscV/ALUnit/ALU_In_1
add wave -noupdate -group EX -group ALU -radix hexadecimal /RiscVTestbench/RiscV/ALUnit/ALU_In_2
add wave -noupdate -group EX -group ALU -radix hexadecimal /RiscVTestbench/RiscV/ALUnit/Op
add wave -noupdate -group EX -group ALU -radix hexadecimal /RiscVTestbench/RiscV/ALUnit/Res
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Rs_Data_1
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Rs_Data_2
add wave -noupdate -group MEM -radix unsigned /RiscVTestbench/RiscV/C.ALU_Result
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Imm
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Wr_Address
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Mem_Read
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Reg_Write
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Mem_Write
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.PC_Imm
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.CSR_Read
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.CSR_Write
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Reg_Src
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/C.Mem_to_Reg
add wave -noupdate -group MEM -radix hexadecimal /RiscVTestbench/RiscV/Mem_Data_Out
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/EX_MEM_RD
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/MEM_WB_RD
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/ID_EX_RS1
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/ID_EX_RS2
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/MEM_WB_REG_WRITE
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/EX_MEM_REG_WRITE
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/Forward_A
add wave -noupdate -group {FORWARDING UNIT} -radix hexadecimal /RiscVTestbench/RiscV/Forwarding_Unit/Forward_B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {276 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 487
configure wave -valuecolwidth 105
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {45 ns} {313 ns}
