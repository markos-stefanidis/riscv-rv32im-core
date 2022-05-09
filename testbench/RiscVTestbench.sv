`timescale 1ns/1ns

module RiscVTestbench;

	logic Clk;
	logic Rst;


	initial begin
		Clk <= 0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
		Rst <= 1;
		#40;
		Rst <= 0;
	end

	TopLevel RiscV(
		.Clk (Clk),
		.Rst (Rst)
	);

	integer index;

	initial begin
		for(index = 0; index < 2**18; index++) begin
			RiscV.Instruction_Memory.InstrMem[index] <= 32'b0;
		end
		#5;
		$readmemh("../instructions.mem", RiscV.Instruction_Memory.InstrMem);
	end

	//initial begin
	//	$readmemh("../test.o", RiscV.InstructionMemory.InstrMem);
	//end

	function string DecodeInst (input logic [31:0] Instruction, output string Assembly);
		logic [6:0] OpCode;
		logic [2:0] Func3;
		logic [6:0] Func7;
		logic [31:0] Immediate;
		logic [5:0] Rs1;
		logic [5:0] Rs2;
		logic [5:0] Rd;
		logic [12:0] CSR;

		string Assembly1;
		string Assembly2;
		string Assembly3;
		string Assembly4;

		OpCode = Instruction[6:0];
		Func3 = Instruction[14:12];
		Func7 = Instruction[31:25];
		Rs1 = Instruction[19:15];
		Rs2 = Instruction[24:20];
		Rd = Instruction[11:7];
		CSR = Instruction[31:20];


		case(OpCode)
			7'b1110011: begin
				case(Func3)
					3'b010: begin
						Assembly1 = "csrr ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(CSR);
						Assembly3 = {"csr", Assembly3};
						Assembly4 = "";
					end

					3'b001: begin
						Assembly1 = "csrw ";
						Assembly2.itoa(CSR);
						Assembly2 = {"csr", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3};
						Assembly4 = "";
					end
				endcase
			end

			7'b0110011: begin
				case(Func3)
					3'b000: begin
						case(Func7)
							7'b0000000: begin
								Assembly1 = "add ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0100000: begin
								Assembly1 = "sub ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0100001: begin
								Assembly1 = "mul ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end
						endcase
					end

					3'b111: begin
						Assembly1 = "and ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b110: begin
						Assembly1 = "or ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b100: begin
						Assembly1 = "xor ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b010: begin
						Assembly1 = "slt ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b011: begin
						Assembly1 = "sltu ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b101: begin
						case(Func7)
							7'b0100000: begin
								Assembly1 = "sra ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0000000: begin
								Assembly1 = "srl ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end
						endcase
					end

					3'b001: begin

						Assembly1 = "sll ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end
				endcase
			end

			7'b0010011: begin
				Immediate = Instruction[31:20];
				case(Func3)
					3'b000: begin
						if(Rs1 == 0) begin
							Assembly1 = "li ";
							Assembly2.itoa(Rd);
							Assembly2 = {"x", Assembly2, ", "};
							Assembly3.itoa($signed(Immediate));
							Assembly4 = "";
						end else if (Immediate == 0) begin
							Assembly1 = "mv ";
							Assembly2.itoa(Rd);
							Assembly2 = {"x", Assembly2, ", "};
							Assembly3.itoa(Rs1);
							Assembly4 = "";
						end else begin
							Assembly1 = "addi ";
							Assembly2.itoa(Rd);
							Assembly2 = {"x", Assembly2, ", "};
							Assembly3.itoa(Rs1);
							Assembly3 = {"x", Assembly3, ", "};
							Assembly4.itoa($signed(Immediate));
						end
					end

					3'b111: begin
						Assembly1 = "andi ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b110: begin
						Assembly1 = "ori ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b100: begin
						Assembly1 = "xori ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b010: begin
						Assembly1 = "slti ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b011: begin
						Assembly1 = "sltiu ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b101: begin
						case(Func7)
							7'b0100000: begin
								Assembly1 = "srai ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa($signed(Instruction[24:20]));
							end

							7'b0000000: begin
								Assembly1 = "srli ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa($signed(Instruction[24:20]));
							end
						endcase
					end

					3'b001: begin
						Assembly1 = "slli ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Instruction[24:20]));
					end

				endcase
			end

			7'b0110111: begin
				Assembly1 = "lui ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Instruction[31:12]));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b0010111: begin
				Assembly1 = "auipc ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Instruction[31:12]));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b0000011: begin
				Assembly1 = "lw ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa(Rs1);
				Assembly4.itoa($signed(Instruction[31:20]));
				Assembly3 = {Assembly4, "(x", Assembly3, ")"};
				Assembly4 = {""};
			end

			7'b0100011: begin
				Assembly1 = "sw ";
				Assembly2.itoa(Rs2);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa(Rs1);
				Assembly4.itoa($signed({Instruction[31:25], Instruction[11:7]}));
				Assembly3 = {Assembly4, "(x", Assembly3, ")"};
				Assembly4 = {""};
			end

			7'b1101111: begin
				Assembly1 = "jal ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Instruction[31:12]));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b1100111: begin
				case(Rd)
					5'b00000: begin
						Assembly1 = "jr x";
						Assembly2.itoa(Rs1);
						Assembly3 = {""};
						Assembly4 = {""};
					end

					default: begin
						Assembly1 = "jalr ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs1);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
						Assembly4 = {""};
					end
				endcase
			end

			7'b1100011: begin
				case(Func3)
					3'b000: begin
						Assembly1 = "beq ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end

					3'b001: begin
						Assembly1 = "bne ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end

					3'b100: begin
						Assembly1 = "blt ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end

					3'b101: begin
						Assembly1 = "bge ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end

					3'b110: begin
						Assembly1 = "bltu ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end

					3'b111: begin
						Assembly1 = "bgeu ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {""};
					end
				endcase
			end

			default: begin
				Assembly1 = "nop ";
				Assembly2 = "";
				Assembly3 = "";
				Assembly4 = "";
			end

		endcase

		Assembly = {Assembly1, Assembly2, Assembly3, Assembly4};
	endfunction

	string IF;
	string ID;
	string EX;
	string MEM;
	string WB;
	integer CLK_COUNTER = 0;
	logic [31:0] PC = 0;
	logic [31:0] NEXT_PC = 0;

	always_ff @ (posedge Clk) begin
		if(Rst) begin
			$display("---RESETING---");
			IF <= "nop";
			ID <= "nop";
			EX <= "nop";
			MEM <= "nop";
			WB <= "nop";
			CLK_COUNTER <= 0;
			PC <= 0;
			NEXT_PC <= 0;
		end else begin
			DecodeInst(RiscV.Instruction, IF);
			PC <= RiscV.PC;
			NEXT_PC <= RiscV.Next_PC;

			if (RiscV.PC_Sel) begin
				ID <= "flushed";
			end else if (~RiscV.FIFO_Stall && ~RiscV.Hazard_Stall) begin
				ID <= IF;
			end

			if (RiscV.PC_Sel || RiscV.Hazard_Stall) begin
				EX <= "flushed";
			end else if (~RiscV.FIFO_Stall) begin
				EX <= ID;
			end

			MEM <= (RiscV.FIFO_Stall) ? {MEM, "(stalled)"} : EX;
			WB <= (RiscV.FIFO_Stall || RiscV.FIFO_Flush) ? "flushed": MEM;
			CLK_COUNTER <= CLK_COUNTER + 1;

			$display("----------------------------------------------------------------------------------------------------");
			$display("");
			$display("Cycle: %d | Program Counter: %d | Next Program Counter: %d", CLK_COUNTER, PC, NEXT_PC);
			$display("");
			$display("IF: %s -> ID: %s -> EX: %s -> MEM: %s -> WB: %s", IF, ID, EX, MEM, WB);
			$display("");
		end


	end

	//always_comb begin
	//		$display("-------------------------------------------------------------------------------------");
	//		$display("Cycle: %d | Program Counter: %d | Next Program Counter: %d", CLK_COUNTER, PC, NEXT_PC);
	//		$display("IF: %s | ID: %s | EX: %s | MEM: %s | WB: %s", IF, ID, EX, MEM, WB);
	//		$display("-------------------------------------------------------------------------------------");
	//end

endmodule

