module CSRControl(
	input logic CSR,
	input logic[2:0] func3,
	output logic CSR_Write,
	output logic CSR_Read);

	assign CSR_Write = (CSR && func3 == 3'b001);
	assign CSR_Read = (CSR && func3 == 3'b010);

endmodule

