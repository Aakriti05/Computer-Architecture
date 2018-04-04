`timescale 1ns/10ps

module tb_extend_8_to_16();

endmodule


module extend_8_to_16(out, in, ExOp);

	output reg [15:0] out;
	input  [7:0] in;
	input ExOp ;

	always@(in)
	begin
	out = (ExOp)?((in[7])?{8'hff,in}:{8'b0,in}):({8'b0,in}); 
	end
	
endmodule 
	