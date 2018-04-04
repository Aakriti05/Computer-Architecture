`timescale 1ns/10ps

module tb_extend_12_to_16();
endmodule


module extend_12_to_16(out, in);

	output reg [15:0] out;
	input  [11:0] in;

	always@(in)
	begin
	out = (in[11])?({4'hf,in}):({4'h0,in}); 
	end
	
endmodule 
	