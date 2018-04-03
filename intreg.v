`timescale 1ns/10ps

//test bench module
module tb_intreg();

endmodule
 

 
module intreg(int_out,int_in,IRWrite,IRRead);
//declare inputs and outputs
output reg [15:0] int_out;
input [15:0] int_in;
reg [15:0] hidden;
input IRWrite,IRRead;

always @(*)
begin
	if(IRWrite)
		hidden = int_in;
	else if(IRRead)
		int_out = hidden;
end
endmodule 

