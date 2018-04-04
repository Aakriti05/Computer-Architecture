`timescale 1ns/10ps

//test bench module
module tb_intreg();

// reg [15:0]int_in;
// reg IRWrite,IRRead;
// wire [15:0]int_out;

// intreg uut(int_out,int_in,IRWrite,IRRead);

// initial 
// begin 
// $dumpfile("intreg.vcd"); 
// $dumpvars; 
// end

// initial 
// begin 
// #00 int_in = 15'h0; IRWrite = 1'b1;
// #15 IRWrite = 1'b0; IRRead = 1'b1; 
// #05 int_in = 15'h1; 
// #10 IRWrite = 1'b1; IRRead = 1'b0;
// #100 $finish;
// end

endmodule
 
module intreg(int_out,int_in,IRWrite,IRRead);
//declare inputs and outputs
output reg [15:0] int_out;
input [15:0] int_in;
reg [15:0] hidden;
input IRWrite,IRRead;

always @(*)
begin
	if(IRRead == 1'b1)
		int_out <= hidden;
	if(IRWrite == 1'b1)
		hidden <= int_in;
end
endmodule 

