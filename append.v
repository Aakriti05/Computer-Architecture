`timescale 1ns/10ps

//test bench module
module tb_append();

// reg [1:0]int_in;
// wire [3:0]int_out;

// append11 uut(int_out,int_in);

// initial 
// begin
// 	#00 int_in = 2'b10;
// 	#10 int_in = 2'b11;
// 	#100 $finish;
// end

// initial
// begin
// $dumpfile("append.vcd");
// $dumpvars;
// end
endmodule

module append10(int_out,int_in);
//declare inputs and outputs
output reg [3:0] int_out;
input [1:0] int_in;

always @(*)
begin
	int_out = {2'b10,int_in};
end
endmodule 

module append11(int_out,int_in);
//declare inputs and outputs
output reg [3:0] int_out;
input [1:0] int_in;

always @(*)
begin
	int_out = {2'b11,int_in};
end
endmodule 

