module CSRFile(
	input logic Clk,
	input logic Rst,
	input logic CSR_Read,
	input logic CSR_Write,
	input logic[11:0] CSR_Address,
	input logic[31:0] CSR_Wr_Data,
	input logic Completed_Instruction,
	output logic Stall,
	output logic[31:0] CSR_Rd_Data,
	output logic Flush,
	output logic[31:0] Completed_Instructions,
	output logic[31:0] Clock_Cycles);

	logic coreid;
	logic numcores;
	logic FIFO_Full;
	logic FIFO_Empty;
	logic stats_en;
	logic[31:0] proc2mngr;
	logic[31:0] mngr2proc;

	always_ff@(posedge Clk, posedge Rst) begin
		numcores <= 1'b1;
		coreid <= 1'b0;

		if (stats_en) begin
			Clock_Cycles <= Clock_Cycles + 1;
			Completed_Instructions <= Completed_Instructions + {31'b0, Completed_Instruction};
		end

		if (Rst) begin
			proc2mngr <= 32'b0;
			mngr2proc <= 32'b0;
			stats_en <= 1'b0;
			Clock_Cycles <= 32'b0;
			Completed_Instructions <= 32'b0;
			CSR_Rd_Data <= 32'b0;
			FIFO_Empty <= 1'b1;
			FIFO_Full <= 1'b0;
			Stall <= 1'b0;
			Flush <= 1'b0;
		end else if (~Stall) begin
			Flush <= 0;

			if (CSR_Read) begin
				if (CSR_Address == 12'hF14) CSR_Rd_Data <= {31'b0, coreid};
				if (CSR_Address == 12'hFC1) CSR_Rd_Data <= {31'b0, numcores};
				if (CSR_Address == 12'h7C1) CSR_Rd_Data <= {31'b0, stats_en};
				if (CSR_Address == 12'hFC0 && ~FIFO_Empty) begin
					CSR_Rd_Data <= mngr2proc;
					mngr2proc <= proc2mngr;
					FIFO_Empty <= (~FIFO_Full);
					FIFO_Full <= 1'b0;
				end else if (CSR_Address == 12'hFC0 && FIFO_Empty) Stall <= 1;
			end

			if (CSR_Write) begin
					if (CSR_Address == 12'h7C1) 	stats_en <=  CSR_Wr_Data[0];
					if (CSR_Address == 12'h7C0 && ~FIFO_Full) begin
						proc2mngr <= CSR_Wr_Data;
						if (FIFO_Empty) mngr2proc <= CSR_Wr_Data;
						FIFO_Full <= (~FIFO_Empty);
						FIFO_Empty <= 1'b0;
				end else if (CSR_Address == 12'h7C0 && FIFO_Full) Stall <= 1;
			end
		end else if (Stall) begin
			Flush <= 1;
			Stall <= 0;
		end
	end


endmodule

