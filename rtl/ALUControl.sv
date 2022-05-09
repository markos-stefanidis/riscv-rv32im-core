module ALUControl(
	input logic[1:0] ALU_Op,
	input logic[6:0] func7,
	input logic[2:0] func3,
	output logic[3:0] Op);

	assign Op[0] =  (func3 == 3'b110 && ALU_Op == 2'b10) || // OR
					(func3 == 3'b100 && ALU_Op == 2'b10) || // XOR
					(func3 == 3'b101 && ALU_Op == 2'b10 && func7 == 7'b0000000) || // SRL
					(func3 == 3'b000 && ALU_Op == 2'b10 && func7 == 7'b0100000) || // SUB
					(func3 == 3'b011 && ALU_Op == 2'b10) || // SLTU
					(func3 == 3'b110 && ALU_Op == 2'b01) || // BLTU
					(func3 == 3'b000 && ALU_Op == 2'b01) || // BEQ
					(func3 == 3'b101 && ALU_Op == 2'b01) || // BGE
					(func3 == 3'b110 && ALU_Op == 2'b11) || //ORI
					(func3 == 3'b100 && ALU_Op == 2'b11) || // XORI
					(func3 == 3'b011 && ALU_Op == 2'b11) || //SLTIU
					(func3 == 3'b101 && ALU_Op == 2'b11); //SRLI


	assign Op[1] =  (func3 == 3'b000 && ALU_Op == 2'b10 && func7 == 7'b0000000) || // ADD
					(func3 == 3'b100 && ALU_Op == 2'b10) || // XOR
					(func3 == 3'b101 && ALU_Op == 2'b10 && func7 == 7'b0100000) || // SRA
					(func3 == 3'b000 && ALU_Op == 2'b10 && func7 == 7'b0100000) || // SUB
					(func3 == 3'b010 && ALU_Op == 2'b10) || // SLT
					(func3 == 3'b100 && ALU_Op == 2'b01) || // BLT
					(func3 == 3'b000 && ALU_Op == 2'b01) || // BEQ
					(func3 == 3'b111 && ALU_Op == 2'b01) || // BGEU
					(ALU_Op == 2'b00) || // SW, LW;
					(func3 == 3'b000 && ALU_Op == 2'b11) || // ADDI
					(func3 == 3'b100 && ALU_Op == 2'b11) || // XORI
					(func3 == 3'b010 && ALU_Op == 2'b11) || //SLTI
					(func3 == 3'b101 && ALU_Op == 2'b11 && func7 == 7'b010000); //SRAI

	assign Op[2] =  (func3 == 3'b001 && ALU_Op == 2'b10) || //SLL
					(func3 == 3'b101 && ALU_Op == 2'b10 && func7 == 7'b0000000) || // SRL
					(func3 == 3'b101 && ALU_Op == 2'b10 && func7 == 7'b0100000) || // SRA
					(func3 == 3'b000 && ALU_Op == 2'b10 && func7 == 7'b0100000) || // SUB
					(func3 == 3'b001 && ALU_Op == 2'b01) || // BNE
					(func3 == 3'b101 && ALU_Op == 2'b01) || // BGE
					(func3 == 3'b111 && ALU_Op == 2'b01) || // BGEU
					(func3 == 3'b101 && ALU_Op == 2'b11 && func7 == 7'b010000) || //SRAI
					(func3 == 3'b101 && ALU_Op == 2'b11) || //SRLI
					(func3 == 3'b001 && ALU_Op == 2'b11); //SLLI

	assign Op[3] =  (func3 == 3'b000 && ALU_Op == 2'b10 && func7 == 7'b0000001) || // MUL
					(func3 == 3'b011 && ALU_Op == 2'b10) || // SLTU
					(func3 == 3'b010 && ALU_Op == 2'b10) || // SLT
					(func3 == 3'b010 && ALU_Op == 2'b11) || //SLTI
					(func3 == 3'b011 && ALU_Op == 2'b11) || //SLTIU
					(ALU_Op == 2'b01); // BLTU, BLT, BEQ, BNE, BGE, BGEU

endmodule

