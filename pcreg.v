`timescale 1ns/10ps

//test bench module
module tb_pcreg();

endmodule

module pcreg(pcaddout,pcaddinp,PCWrite);
//declare inputs and outputs
output reg [14:0] pcaddout;
input [14:0] pcaddinp;
input PCWrite;

always @(*)
begin
	if(PCWrite)
		pcaddout = pcaddinp;
end
endmodule 

