module Control(
	input logic[6:0] Instruction,
	output logic Branch,
	output logic Mem_Read,
	output logic Mem_Write,
	output logic[1:0] ALU_Op,
	output logic Reg_Write,
	output logic Mem_to_Reg,
	output logic ALU_Src,
	output logic JALR,
	output logic JAL,
	output logic CSR_Sel,
	output logic[1:0] Reg_Src); /* 00: Reg2Reg, 01: Reg = PC + 4, 10: Reg = Imm (7'b0110111), 11: Reg = PC + imm (7'b0010111) */

	logic[6:0] R_Type;
	logic[6:0] R_Type_I;
	logic[6:0]  CSR;
	logic[6:0] LUI;
	logic[6:0] AUIPC;
	logic[6:0] LW;
	logic[6:0] SW;
	logic[6:0] JAL_opcode;
	logic[6:0] JALR_opcode;
	logic[6:0] Branch_opcode;

	assign R_Type = 7'b0110011;
	assign R_Type_I = 7'b0010011;
	assign CSR = 7'b1110011;
	assign LUI = 7'b0110111;
	assign AUIPC = 7'b0010111;
	assign LW = 7'b0000011;
	assign SW = 7'b0100011;
	assign JAL_opcode = 7'b1101111;
	assign JALR_opcode = 7'b1100111;
	assign Branch_opcode = 7'b1100011;




	always_comb begin
		JAL= (Instruction == JAL_opcode);
		Branch = (Instruction == Branch_opcode);
		Mem_Read = (Instruction == LW);
		Mem_Write = (Instruction == SW);
		Reg_Write = ((Instruction == R_Type) || (Instruction == R_Type_I) || (Instruction == LUI) || (Instruction == AUIPC) || (Instruction == LW) || (Instruction == JAL_opcode) || (Instruction == JALR_opcode));
		Mem_to_Reg = (Instruction == LW);
		ALU_Src = ((Instruction == R_Type_I) || (Instruction == LW) || (Instruction == SW) || (Instruction == JALR_opcode));
		JALR = (Instruction == JALR_opcode);
		ALU_Op[0] = ((Instruction == Branch_opcode) || (Instruction == R_Type_I));
		ALU_Op[1] = ((Instruction == R_Type_I) || (Instruction == R_Type));
		Reg_Src[0] = ((Instruction == JALR_opcode) || (Instruction == JAL_opcode) || (Instruction == AUIPC));
		Reg_Src[1] = ((Instruction == LUI) || (Instruction == AUIPC));
		CSR_Sel = (Instruction == CSR);
	end
endmodule

