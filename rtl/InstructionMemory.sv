module InstructionMemory(
	input logic[17:0] PC,
	output logic[31:0] Instruction
);

	logic[31:0] InstrMem[0:2**18 - 1];

	assign Instruction = InstrMem[PC];

endmodule

