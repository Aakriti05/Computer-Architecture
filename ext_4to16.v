`timescale 1ns/10ps

module tb_extend_4_to_16();

	wire [15:0] out;
	reg [3:0] in;
	reg ExOp;
	
	extend_4_to_16 uut(out, in);
	
	initial
	begin
		#00 in=4'h9; 
		#20 in=4'h2; 
		#20 $stop;
	end 
	
	initial
	begin
	$monitor("time=%3d, in=%4b, out=%16b",$time,in,out);
	end
	
endmodule


module extend_4_to_16(out, in);

	output reg [15:0] out;
	input  [3:0] in;

	always@(in)
	begin
	out = {12'b0,in};
	end
	
endmodule 
	