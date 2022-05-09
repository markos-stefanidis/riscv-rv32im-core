module MUX4(
	input logic[31:0] a,
	input logic[31:0] b,
	input logic[31:0] c,
	input logic[31:0] d,
	input logic[1:0] sel,
	output logic[31:0] y);

	//assign y = (sel[1]) ? (sel[0] ? d : c) : (sel[0] ? b : a);
	assign y = (sel == 2'b00) ? a : (sel == 2'b01) ? b : (sel == 2'b10) ? c : d;

endmodule

