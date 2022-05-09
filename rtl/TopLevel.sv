`include "Pipeline_PKG.sv"
import Pipeline::*;

module TopLevel(
	input logic Clk,
	input logic Rst);

	logic[31:0] Wr_Data;
	logic[31:0] Completed_Instructions;
	logic[31:0] Clock_Cycles;
	logic[31:0] Reg_File[0:31];

	logic[31:0] PC;
	logic[31:0] PC_Plus_Four;
	logic[31:0] BR_PC;
	logic[31:0] Instruction;
	logic PC_Sel;
	logic[31:0] Next_PC;
	logic Reg_Write;
	logic[31:0] Rs_Data_1;
	logic[31:0] Rs_Data_2;
	logic[31:0] Imm;
	logic Branch;
	logic Mem_Read;
	logic Mem_Write;
	logic[1:0] ALU_Op;
	logic Mem_to_Reg;
	logic ALU_Src;
	logic JALR;
	logic CSR_Sel;
	logic[1:0] Reg_Src;
	logic[3:0] Op;
	logic[31:0] ALU_In_1;
	logic[31:0] ALU_In_2;
	logic[31:0] ALU_Result;
	logic[31:0] PC4;
	logic[31:0] PC_Imm;
	logic CSR_Write;
	logic CSR_Read;
	logic[31:0] Mem_Data_Out;
	logic[31:0] CSR_Rd_Data;
	logic[31:0] Reg_Wr_Data;
	logic[31:0] WB_Data;
	logic Hazard_Stall;
	logic FIFO_Stall;
	logic[1:0] Forward_A;
	logic[1:0] Forward_B;
	logic CSRMem_to_Reg;
	logic[31:0] Forward_B_Res;
	logic[31:0] Mem_Result;
	logic JAL;
	logic FIFO_Flush;
	logic Instruction_Started;


	logic Control_Reg_Write;
	assign Four = 32'd4;

	IF_ID A;
	ID_EX B;
	EX_MEM C;
	MEM_WB D;

	HazardDetection Hazard_Detection(
		.IF_ID_RS_1 (A.Instruction[19:15]),
		.IF_ID_RS_2 (A.Instruction[24:20]),
		.ID_EX_RD (B.Wr_Address),
		.ID_EX_MEM_READ (B.Mem_Read),
		.ID_EX_CSR_READ (CSR_Read),
		.Stall (Hazard_Stall));

	ForwardingUnit Forwarding_Unit(
		.EX_MEM_RD (C.Wr_Address),
		.MEM_WB_RD (D.Wr_Address),
		.ID_EX_RS1 (B.Rs_Address_1),
		.ID_EX_RS2 (B.Rs_Address_2),
		.MEM_WB_REG_WRITE (D.Reg_Write),
		.EX_MEM_REG_WRITE (C.Reg_Write),
		.Forward_A (Forward_A),
		.Forward_B (Forward_B));


	assign PC_Plus_Four = PC + 4;

	MUX2 PC_Mux(
		.a (PC_Plus_Four),
		.b (BR_PC),
		.sel (PC_Sel),
		.y (Next_PC));

	PC PC_Reg(
		.Next_PC (Next_PC),
		.Clk (Clk),
		.Rst (Rst),
		.FIFO_Stall (FIFO_Stall),
		.Hazard_Stall (Hazard_Stall),
		.Curr_PC (PC));

	InstructionMemory Instruction_Memory(
		.PC (PC[19:2]),
		.Instruction (Instruction));

	assign Instruction_Started = (Instruction != 32'b0);

	always_ff @ (posedge Clk) begin // IF_ID
		if (Rst || PC_Sel) begin
			A.PC <= 32'b0;
			A.Instruction <= 32'b0;
			A.Instruction_Started <= 1'b0;
		end else if (~(Hazard_Stall || FIFO_Stall)) begin
			A.PC <= PC;
			A.Instruction <= Instruction;
			A.Instruction_Started <= Instruction_Started;
		end else if (Hazard_Stall) A.Instruction_Started <= 1'b0;
	end


	RegisterFile Register_File(
		.Rst (Rst),
		.Clk (Clk),
		.Reg_Write (D.Reg_Write),
		.Rs_Address_1 (A.Instruction[19:15]),
		.Rs_Address_2 (A.Instruction[24:20]),
		.Wr_Address (D.Wr_Address),
		.Wr_Data (Wr_Data),
		.Rs_Data_1 (Rs_Data_1),
		.Rs_Data_2 (Rs_Data_2));

	ImmGen Imm_Gen(
		.Instruction (A.Instruction),
		.Imm (Imm));

	Control Control_Unit(
		.Instruction (A.Instruction[6:0]),
		.Branch (Branch),
		.Mem_Read (Mem_Read),
		.Mem_Write (Mem_Write),
		.ALU_Op (ALU_Op),
		.Reg_Write (Control_Reg_Write),
		.Mem_to_Reg (Mem_to_Reg),
		.ALU_Src (ALU_Src),
		.JAL (JAL),
		.JALR (JALR),
		.CSR_Sel (CSR_Sel),
		.Reg_Src (Reg_Src));

	CSRControl CSR_Control(
		.CSR (CSR_Sel),
		.func3 (A.Instruction[14:12]),
		.CSR_Write (CSR_Write),
		.CSR_Read (CSR_Read));

		assign Reg_Write = (Control_Reg_Write || CSR_Read);

	always_ff @ (posedge Clk, posedge Rst) begin // ID_EX
		if (Rst || PC_Sel || Hazard_Stall) begin
			B.Reg_Src <= 2'b0;
			B.PC <= 32'b0;
			B.Rs_Data_1 <= 32'b0;
			B.Rs_Data_2 <= 32'b0;
			B.Rs_Address_1 <= 5'b0;
			B.Rs_Address_2 <= 5'b0;
			B.Wr_Address <= 5'b0;
			B.Imm <= 32'b0;
			B.Branch <= 1'b0;
			B.Mem_Read <= 1'b0;
			B.Mem_Write <= 1'b0;
			B.ALU_Op <= 2'b0;
			B.Reg_Write <= 1'b0;
			B.Mem_to_Reg <= 1'b0;
			B.ALU_Src <= 1'b0;
			B.JALR <= 1'b0;
			B.CSR_Read <= 1'b0;
			B.CSR_Write <= 1'b0;
			B.func7 <= 7'b0;
			B.func3 <= 3'b0;
			B.JAL <= 1'b0;
			B.Instruction_Started <= 1'b0;
		end else if (~FIFO_Stall) begin
			B.Reg_Src <= Reg_Src;
			B.PC <= A.PC;
			B.Rs_Data_1 <= Rs_Data_1;
			B.Rs_Data_2 <= Rs_Data_2;
			B.Rs_Address_1 <= A.Instruction[19:15];
			B.Rs_Address_2 <= A.Instruction[24:20];
			B.Wr_Address <= A.Instruction[11:7];
			B.Imm <= Imm;
			B.Branch <= Branch;
			B.Mem_Read <= Mem_Read;
			B.Mem_Write <= Mem_Write;
			B.ALU_Op <= ALU_Op;
			B.Reg_Write <= Reg_Write;
			B.Mem_to_Reg <= Mem_to_Reg;
			B.ALU_Src <= ALU_Src;
			B.JALR <= JALR;
			B.CSR_Read <= CSR_Read;
			B.CSR_Write <= CSR_Write;
			B.func7 <= A.Instruction[31:25];
			B.func3 <= A.Instruction[14:12];
			B.JAL <= JAL;
			B.Instruction_Started <= A.Instruction_Started;
		end else if (Hazard_Stall) B.Instruction_Started <=1'b0;
	end


	MUX4 Forward_A_Mux(B.Rs_Data_1,  Wr_Data, Mem_Result, B.Rs_Data_1, Forward_A, ALU_In_1);
	MUX4 Forward_B_Mux(B.Rs_Data_2,  Wr_Data, Mem_Result, B.Rs_Data_2, Forward_B, Forward_B_Res);

	MUX2 ALU_Input(Forward_B_Res, B.Imm, B.ALU_Src, ALU_In_2);

	ALUControl ALU_Control(
		.ALU_Op (B.ALU_Op),
		.func7 (B.func7),
		.func3 (B.func3),
		.Op (Op));

	ALU ALUnit(
		.ALU_In_1 (ALU_In_1),
		.ALU_In_2 (ALU_In_2),
		.Op (Op),
		.Res (ALU_Result));

	BranchControl Branch_Control(
		.Branch (B.Branch),
		.JALR (B.JALR),
		.JAL (B.JAL),
		.PC (B.PC),
		.Imm (B.Imm),
		.Res (ALU_Result),
		.PC_Sel (PC_Sel),
		.BR_PC (BR_PC),
		.PC4 (PC4),
		.PC_Imm (PC_Imm));


	always_ff @ (posedge Clk, posedge Rst) begin // EX_MEM
		if (Rst) begin
			C.Rs_Data_1 <= 32'b0;
			C.Rs_Data_2 <= 32'b0;
			C.ALU_Result <= 32'b0;
			C.PC4 <= 32'b0;
			C.Imm <= 32'b0;
			C.Wr_Address <= 5'b0;
			C.Mem_Read <= 1'b0;
			C.Reg_Write <= 1'b0;
			C.Mem_Write <= 1'b0;
			C.PC_Imm <= 32'b0;
			C.CSR_Read <= 1'b0;
			C.CSR_Write <= 1'b0;
			C.Reg_Src <= 2'b0;
			C.Mem_to_Reg <= 1'b0;
			C.Instruction_Started <= 1'b0;
		end else if (~FIFO_Stall) begin
			C.Rs_Data_1 <= ALU_In_1;
			C.Rs_Data_2 <= Forward_B_Res;
			C.ALU_Result <= ALU_Result;
			C.PC4 <= PC4;
			C.Imm <= B.Imm;
			C.Wr_Address <= B.Wr_Address;
			C.Mem_Read <= B.Mem_Read;
			C.Reg_Write <= B.Reg_Write;
			C.Mem_Write <= B.Mem_Write;
			C.PC_Imm <= PC_Imm;
			C.CSR_Read <= B.CSR_Read;
			C.CSR_Write <= B.CSR_Write;
			C.Reg_Src <= B.Reg_Src;
			C.Mem_to_Reg <= B.Mem_to_Reg;
			C.Instruction_Started <= B.Instruction_Started;
		end else if (FIFO_Stall) C.Instruction_Started <= 0;
	end

	MUX4 Mem_Result_Mux(C.ALU_Result, C.PC4, C.Imm, C.PC_Imm, C.Reg_Src, Mem_Result);

	DataMemory Data_Memory(
		.Clk (Clk),
		.Mem_Write (C.Mem_Write),
		.Mem_Read (C.Mem_Read),
		.Address (C.ALU_Result[19:0]),
		.Data_In (C.Rs_Data_2),
		.Data_Out (Mem_Data_Out));

	CSRFile CSR_File(
		.Clk (Clk),
		.Rst (Rst),
		.CSR_Read (C.CSR_Read),
		.CSR_Write (C.CSR_Write),
		.CSR_Address (C.Imm[11:0]),
		.CSR_Wr_Data (C.Rs_Data_1),
		.Completed_Instruction (D.Instruction_Started),
		.Stall (FIFO_Stall),
		.CSR_Rd_Data (CSR_Rd_Data),
		.Flush (FIFO_Flush),
		.Completed_Instructions (Completed_Instructions),
		.Clock_Cycles (Clock_Cycles));

	MUX2 CSRorMEM(CSR_Rd_Data, Mem_Data_Out, C.Mem_to_Reg, Reg_Wr_Data);

	assign CSRMem_to_Reg = (C.CSR_Read || C.Mem_to_Reg);

	always_ff @ (posedge Clk, posedge Rst) begin  // MEM_WB
		if (Rst || FIFO_Flush || FIFO_Stall) begin
			D.CSRMem_to_Reg <= 1'b0;
			D.ALU_Result <= 32'b0;
			D.Wr_Address <= 5'b0;
			D.Reg_Wr_Data <= 32'b0;
			D.PC4 <= 32'b0;
			D.Imm <= 32'b0;
			D.PC_Imm <= 32'b0;
			D.Reg_Write <= 1'b0;
			D.Reg_Src <= 2'b0;
			D.Instruction_Started <= 1'b0;
		end else begin
			D.CSRMem_to_Reg <= CSRMem_to_Reg;
			D.ALU_Result <= C.ALU_Result;
			D.Wr_Address <= C.Wr_Address;
			D.Reg_Wr_Data <= Reg_Wr_Data;
			D.PC4 <= C.PC4;
			D.Imm <= C.Imm;
			D.PC_Imm <= C.PC_Imm;
			D.Reg_Write <= C.Reg_Write;
			D.Reg_Src <= C.Reg_Src;
			D.Instruction_Started <= C.Instruction_Started;
		end
	end

	MUX2 ALUorMem(D.ALU_Result, D.Reg_Wr_Data, D.CSRMem_to_Reg, WB_Data);

	MUX4 RegData(WB_Data, D.PC4, D.Imm, D.PC_Imm, D.Reg_Src, Wr_Data);

endmodule

