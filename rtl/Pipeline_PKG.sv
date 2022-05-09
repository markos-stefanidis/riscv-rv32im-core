package Pipeline;

		typedef struct packed{
			logic[31:0] PC;
			logic[31:0] Instruction;
			logic Instruction_Started;
		} IF_ID;

		typedef struct packed{
			logic[1:0] Reg_Src;
			logic[31:0] PC;
			logic[31:0] Rs_Data_1;
			logic[31:0] Rs_Data_2;
			logic[4:0] Rs_Address_1;
			logic[4:0] Rs_Address_2;
			logic[4:0] Wr_Address;
			logic[31:0] Imm;
			logic Branch;
			logic Mem_Read;
			logic Mem_Write;
			logic[1:0] ALU_Op;
			logic Reg_Write;
			logic Mem_to_Reg;
			logic ALU_Src;
			logic JALR;
			logic CSR_Read;
			logic CSR_Write;
			logic[6:0] func7;
			logic[2:0] func3;
			logic JAL;
			logic Instruction_Started;
		} ID_EX;

		typedef struct packed{
			logic[31:0] Rs_Data_1;
			logic[31:0] Rs_Data_2;
			logic[31:0] ALU_Result;
			logic[31:0] PC4;
			logic[31:0] Imm;
			logic[4:0] Wr_Address;
			logic Mem_Read;
			logic Reg_Write;
			logic Mem_Write;
			logic[31:0] PC_Imm;
			logic CSR_Read;
			logic CSR_Write;
			logic[1:0] Reg_Src;
			logic Mem_to_Reg;
			logic Instruction_Started;
		} EX_MEM;

		typedef struct packed{
			logic CSRMem_to_Reg;
			logic[31:0] ALU_Result;
			logic[4:0] Wr_Address;
			logic[31:0] Reg_Wr_Data;
			logic[31:0] PC4;
			logic[31:0] Imm;
			logic[31:0] PC_Imm;
			logic Reg_Write;
			logic[1:0] Reg_Src;
			logic Instruction_Started;
		} MEM_WB;
endpackage

