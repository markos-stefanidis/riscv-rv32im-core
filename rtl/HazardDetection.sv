module HazardDetection(
	input logic[4:0] IF_ID_RS_1,
	input logic[4:0] IF_ID_RS_2,
	input logic[4:0] ID_EX_RD,
	input logic ID_EX_MEM_READ,
	input logic ID_EX_CSR_READ,
	output logic Stall);

	always_comb begin
		Stall = (ID_EX_MEM_READ || ID_EX_CSR_READ) && (((IF_ID_RS_1 == ID_EX_RD) || (IF_ID_RS_2 == ID_EX_RD)) ? 1 : 0);
	end
endmodule

