`timescale 1ns/10ps

//test bench module
module tb_pcreg();

// reg rst, PCWrite;
// reg [14:0]pcaddinp;
// wire [14:0] pcaddout;

// pcreg uut(pcaddout,pcaddinp,PCWrite,rst);

// initial 
// begin
// 	#00 rst = 1'b1; PCWrite = 1'b1;
// 	#04 rst = 1'b0;
// 	#100 $finish;
// end

// initial
// begin
// $dumpfile("pcreg.vcd");
// $dumpvars;
// end
endmodule

module pcreg(pcaddout,pcaddinp,PCWrite, Resetzero);
//declare inputs and outputs
output reg [14:0] pcaddout;
input [14:0] pcaddinp;
input PCWrite, Resetzero;

always @(pcaddinp)
begin
	if(Resetzero == 1'b1)
		pcaddout = 15'b0;
	else if(PCWrite == 1'b1)
		pcaddout = pcaddinp;
end
endmodule 

module temp_pcreg(pcaddout,pcaddinp,PCWrite, clk);
//declare inputs and outputs
output reg [14:0] pcaddout;
input [14:0] pcaddinp;
input PCWrite,clk;

always @(pcaddinp)
begin
	#1 pcaddout = pcaddinp;
end
endmodule 
