`timescale 1ns/10ps

//test bench module
module tb_pcreg();

endmodule

module pcreg(pcaddout,pcaddinp,PCWrite, Resetzero);
//declare inputs and outputs
output reg [14:0] pcaddout;
input [14:0] pcaddinp;
input PCWrite, Resetzero;

always @(*)
begin
	if(Resetzero)
		pcaddout = 15'b0;
	if(PCWrite)
		pcaddout = pcaddinp;
end
endmodule 

