module BranchControl(
	input logic Branch,
	input logic JAL,
	input logic JALR,
	input logic[31:0] PC,
	input logic[31:0] Imm,
	input logic [31:0] Res,
	output logic PC_Sel,
	output logic[31:0] BR_PC,
	output logic[31:0] PC4,
	output logic[31:0] PC_Imm);

	logic BranchSel;

	assign BranchSel = ((Branch && Res[0]) || JAL);

	assign PC4 = PC + 4;
	assign PC_Imm = PC + Imm;

	assign BR_PC = (JALR) ? Res : (Branch || JAL) ? PC_Imm : 32'b0;
	assign PC_Sel = (BranchSel || JALR);

endmodule

