`timescale 1ns/10ps

module tb_extend_4_to_16();
	
endmodule


module extend_4_to_16(out, in);

	output reg [15:0] out;
	input  [3:0] in;

	always@(in)
	begin
	out = {12'b0,in};
	end
	
endmodule 
	