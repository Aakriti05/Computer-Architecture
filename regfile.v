`timescale 1ns/10ps

module tst_regfile();
endmodule

module regfile(a,b,c,regread,regwrite,readregsrc1,readregsrc2,readregsrc3,regwritedst,writedata,clk);

output reg [15:0] a,b,c;
input regread, regwrite, clk;
input [3:0] readregsrc1,readregsrc2,readregsrc3,regwritedst;
input [15:0] writedata;
reg [15:0] regfile[0:15];

initial $readmemh("regfiledata.txt",regfile);

always@(negedge clk)
	begin
		if(regread)
			begin
				a <= regfile[readregsrc1];
				b <= regfile[readregsrc2];
				c <= regfile[readregsrc3];
			end
		if(regwrite) regfile[regwritedst] <= writedata;
	$writememh("regfiledata_2.txt",regfile);
	end
endmodule 
