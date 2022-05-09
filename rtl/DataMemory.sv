module DataMemory(
	input logic Clk,
	input logic Mem_Write,
	input logic Mem_Read,
	input logic [19:0] Address,
	input logic [31:0] Data_In,
	output logic [31:0] Data_Out);

	logic[7:0] Mem[0:2**20 - 1];

	always_ff@(negedge Clk)
	begin
		if (Mem_Write && Address <=32'hFFFFF) begin
			Mem[Address] <= Data_In[7:0];
			Mem[Address + 1] <= Data_In[15:8];
			Mem[Address + 2] <= Data_In[23:16];
			Mem[Address + 3] <= Data_In[31:24];
		end

		if (Mem_Read && Address <= 32'hFFFFF) begin
			Data_Out[7:0] <= Mem[Address];
			Data_Out[15:8] <= Mem[Address + 1];
			Data_Out[23:16] <= Mem[Address + 2];
			Data_Out[31:24] <= Mem[Address + 3];
		end else Data_Out <= 32'b0;
	end

endmodule

