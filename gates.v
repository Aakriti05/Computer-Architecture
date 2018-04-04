`timescale 1ns/10ps

//test bench module
module tb_gates();

// reg a,b;
// wire out;

// or_gate uut(out,a,b);

// initial 
// begin 
// $dumpfile("gates.vcd"); 
// $dumpvars; 
// end

// initial 
// begin 
// #00 a = 1'b0; b = 1'b1;
// #15 a = 1'b1; b = 1'b1; 
// #100 $finish;
// end
endmodule

module and_gate(out,a,b);
//declare inputs and outputs
output reg out;
input a,b;

always @(*)
begin
	out = a&b;
end
endmodule 

module or_gate(out,a,b);
//declare inputs and outputs
output reg out;
input a,b;

always @(*)
begin
	out = a|b;
end
endmodule

