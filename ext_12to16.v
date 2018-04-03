`timescale 1ns/10ps

module tb_extend_12_to_16();

	wire [15:0] out;
	reg [11:0] in;
	reg ExOp;
	
	extend_12_to_16 uut(out, in);
	
	initial
	begin
		#00 in=12'h02; 
		#20 in=12'h9f2; 
		#20 $stop;
	end 
	
	initial
	begin
	$monitor("time=%3d, in=%12b, out=%16b",$time,in,out);
	end
	
endmodule


module extend_12_to_16(out, in);

	output reg [15:0] out;
	input  [11:0] in;

	always@(in)
	begin
	out = (in[11])?({4'hf,in}):({4'h0,in}); 
	end
	
endmodule 
	