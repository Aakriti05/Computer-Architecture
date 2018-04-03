`timescale 1ns/10ps

module tb_mux_4to1();

wire [15:0] out;
reg [15:0] a,b,c,d;
reg [1:0] op;

mux_4to1 uut(out,a,b,c,d,op);

initial
begin
#20  op=2'b00; a=16'd7; b=16'hFFFD; c=16'd56; d=16'hF16D;
#20  op=2'b01; a=16'b0000000000001000; b=16'd4; c=16'd45; d=16'hF0FD;
#20  op=2'b10; a=16'b0000000000001000; b=16'd4; c=16'd45; d=16'hF0FD;
#20  op=2'b11; a=16'b0000000000001000; b=16'd4; c=16'd45; d=16'hF0FD;
#20  $finish;
end
	
initial
begin
$dumpfile("mux_4to1.vcd");
$dumpvars;
end
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

