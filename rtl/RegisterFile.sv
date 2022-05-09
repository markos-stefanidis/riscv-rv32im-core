module RegisterFile(
	input logic Rst,
	input logic Clk,
	input logic Reg_Write,
	input logic[4:0] Rs_Address_1,
	input logic[4:0] Rs_Address_2,
	input logic[4:0] Wr_Address,
	input logic[31:0] Wr_Data,
	output logic[31:0] Rs_Data_1,
	output logic[31:0] Rs_Data_2);


	logic [31:0] Reg_File[0:31];
	integer index;

	always_ff @ (negedge Clk, posedge Rst) begin
		if (Rst) begin
			for(index = 0; index < 32; index++) begin
				Reg_File[index] <= 32'b0;
			end
		end else begin
			Reg_File[0] <= 32'b0;
			if(Reg_Write && Wr_Address != 5'b0) begin
				Reg_File[Wr_Address] <= Wr_Data;
			end
		end
	end

	always_comb begin
		if ((Rs_Address_1 == Wr_Address) && Reg_Write) begin
			Rs_Data_1 = Wr_Data;
		end else begin
			Rs_Data_1 = Reg_File[Rs_Address_1];
		end

		if ((Rs_Address_2 == Wr_Address) && Reg_Write) begin
			Rs_Data_2 = Wr_Data;
		end else begin
			Rs_Data_2 <= Reg_File[Rs_Address_2];
		end
	end
endmodule

