module ImmGen(
	input logic[31:0] Instruction,
	output logic[31:0] Imm);

	always_comb begin
		case(Instruction[6:0])
			7'b1110011 : Imm = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediate
			7'b0000011 : Imm = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediate
			7'b0010011 : Imm = ((Instruction[31:25] == 7'b0100000) && (Instruction[14:12] == 3'b101)) ? {27'b0, Instruction[24:20]} : // I-Immediate SRAI
						{Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediate
			7'b1100111 : Imm = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediate
			7'b0000001 : Imm = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediate
			7'b1101111 : Imm = {Instruction[31] ? 11'h7FF : 11'b0, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0}; // J-Immediate
			7'b1100011 : Imm = {Instruction[31] ? 20'hFFFFF : 20'b0, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; // B-Immediate
			7'b0110111 : Imm = {Instruction[31:12], 12'b0}; // U-Immediate LUI
			7'b0010111 : Imm = {Instruction[31:12], 12'b0}; // U-Immediate AUIPC
			7'b0100011 : Imm = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:25], Instruction[11:8], Instruction[7]}; // S-Immediate
			default : Imm = 32'b0;
		endcase
	end

endmodule

