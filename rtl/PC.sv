module PC(
	input logic[31:0] Next_PC,
	input logic Clk,
	input logic Rst,
	input logic FIFO_Stall,
	input logic Hazard_Stall,
	output logic[31:0] Curr_PC);

	always_ff@(posedge Clk, posedge Rst) begin
		if (Rst) begin
			Curr_PC <= 32'b0;
		end else if  (~(FIFO_Stall || Hazard_Stall)) begin
			Curr_PC <= Next_PC;
		end
	end

endmodule

