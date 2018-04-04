`timescale 1ns/10ps

module tb_mux_4to1();

endmodule
 
module mux_4to1(out,a,b,c,d,op);
	
output reg [15:0] out;
input [15:0] a,b,c,d;
input [1:0] op;
always @(op)
begin
	case(op)
		2'b00: out = a;
		2'b01: out = b;
		2'b10: out = c;
		2'b11: out = d;
		default: out = 16'b0;
	endcase
end
endmodule 

