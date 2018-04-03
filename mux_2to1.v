`timescale 1ns/10ps

module tb_mux_2to1();

endmodule
 
module mux_2to1(out,a,b,op);
	
output reg [3:0] out;
input [3:0] a,b;
input op;
always @(op)
begin
	case(op)
		1'b0: out = a;
		1'b1: out = b;
		default: out = 16'b0;
	endcase
end
endmodule 

module mux_2to1_16bit(out,a,b,op);
	
output reg [15:0] out;
input [15:0] a,b;
input op;
always @(op)
begin
	case(op)
		1'b0: out = a;
		1'b1: out = b;
		default: out = 16'b0;
	endcase
end
endmodule

module mux_2to1_zerof(out,a,op);
	
output reg out;
input a,b;
input op;
always @(op)
begin
	case(op)
		1'b0: out = a;
		1'b1: out = ~a;
		default: out = 16'b0;
	endcase
end
endmodule
