`timescale 1ns/10ps

//test bench module
module tb_append();

endmodule

module append10(int_out,int_in);
//declare inputs and outputs
output reg [3:0] int_out;
input [1:0] int_in;

always @(*)
begin
	int_out = {2'b10,int_out};
end
endmodule 

module append11(int_out,int_in);
//declare inputs and outputs
output reg [3:0] int_out;
input [1:0] int_in;

always @(*)
begin
	int_out = {2'b11,int_out};
end
endmodule 

