module ALU(
	input logic[31:0] ALU_In_1,
	input logic[31:0] ALU_In_2,
	input logic[3:0] Op,
	output logic[31:0] Res);

	always_comb begin
		case(Op)
			4'b0000 : Res = ALU_In_1 & ALU_In_2; //AND
			4'b0001 : Res = ALU_In_1 | ALU_In_2; //OR
			4'b0010 : Res = ALU_In_1 +  ALU_In_2; //ADD
			4'b0011 : Res = ALU_In_1 ^ ALU_In_2; //XOR
			4'b0100 : Res = ALU_In_1 << ALU_In_2[4:0]; //SLL
			4'b0101 : Res = ALU_In_1 >> ALU_In_2[4:0]; //SRL
			4'b0110 : Res = $signed(ALU_In_1) >>> ALU_In_2[4:0]; //SRA
			4'b0111 : Res = $signed(ALU_In_1) - $signed(ALU_In_2); //SUB
			4'b1000 : Res = $signed(ALU_In_1) * $signed(ALU_In_2); //MUL
			4'b1001 : Res = (ALU_In_1 < ALU_In_2) ? 1 : 0; //SLTU, BLTU
			4'b1010 : Res = ($signed(ALU_In_1) < $signed(ALU_In_2)) ? 1 : 0; //SLT, BLT
			4'b1011 : Res = (ALU_In_1 == ALU_In_2) ? 1 : 0; //BEQ
			4'b1100 : Res = (ALU_In_1 != ALU_In_2) ? 1 : 0; //BNE
			4'b1101 : Res = ($signed(ALU_In_1) >= $signed(ALU_In_2)) ? 1 : 0; //BGE
			4'b1110 : Res = (ALU_In_1 >= ALU_In_2) ? 1 : 0; //BGEU
			4'b1111 : Res = 32'b1; //LUI, AUIPC
			default : Res = 0;
		endcase
	end

endmodule

