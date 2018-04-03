`timescale 1ns/10ps

module tb_extend_8_to_16();

	wire [15:0] out;
	reg [7:0] in;
	reg ExOp;
	
	extend_8_to_16 uut(out, in, ExOp);
	
	initial
	begin
		#00 ExOp=1'b0 ; in=8'h02; 
		#20 ExOp=1'b0 ; in=8'hf2; 
		#20 ExOp=1'b1 ; in=8'h02; 
		#20 ExOp=1'b1 ; in=8'hf2; 
		#20 $stop;
	end 
	
	initial
	begin
	$monitor("time=%3d, in=%8b, out=%16b, ExOp=%b ",$time,in,out,ExOp);
	end
	
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
	