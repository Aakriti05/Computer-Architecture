`timescale 1ns/10ps

`define sub 	= 3'b000
`define add 	= 3'b001 
`define exor 	= 3'b010
`define andab 	= 3'b011
`define orab 	= 3'b100
`define shr 	= 3'b101 // shift right a by 1 bit 
`define shl 	= 3'b110 // shift left a by 1 bit 
`define sar 	= 3'b111 // arithmetic shift right a by 1 bit 

module tb_alu_16bit();

endmodule
 
module alu_16bit(zerof,out,a,b,op);
	
output reg [15:0] out;
input [15:0] a,b;
input [2:0] op;
output reg zerof;
reg signed [15:0] temp_a;
// reg one = 15'h1111;
always @(a,b)
begin
	case(op)
		3'b000: out = a+b;
		3'b001: out = a-b;
		3'b101: out = ~(a&b);
		3'b110: out = a|b;
		3'b010: out = a << b;
		3'b011: out = a >> b;
		3'b100: begin
				temp_a = a;
				out =  temp_a >>> b; // shift right arithmetic; works if the numbers are signed
				end
		3'b111: out = {b[14:0],1'b0} + a; //shift addition
		default: out = 16'b0;
	endcase
	if(out == 16'b0)
	begin
		zerof = 1'b1;
	end
	else
	begin
		zerof = 1'b0;
	end
end
endmodule 

