module ForwardingUnit(
	input logic[4:0] EX_MEM_RD,
	input logic[4:0] MEM_WB_RD,
	input logic[4:0] ID_EX_RS1,
	input logic[4:0] ID_EX_RS2,
	input logic MEM_WB_REG_WRITE,
	input logic EX_MEM_REG_WRITE,
	output logic[1:0] Forward_A,
	output logic[1:0] Forward_B);

	assign Forward_A = ((EX_MEM_REG_WRITE) && (EX_MEM_RD != 5'b0) && (EX_MEM_RD == ID_EX_RS1)) ? 2'b10 :
						(((MEM_WB_REG_WRITE) && (MEM_WB_RD != 5'b0) && (MEM_WB_RD == ID_EX_RS1)) ? 2'b01 : 2'b00);
	assign Forward_B = ((EX_MEM_REG_WRITE) && (EX_MEM_RD != 5'b0) && (EX_MEM_RD == ID_EX_RS2)) ? 2'b10 :
						(((MEM_WB_REG_WRITE) && (MEM_WB_RD != 5'b0) && (MEM_WB_RD == ID_EX_RS2)) ? 2'b01 : 2'b00);

endmodule

