`timescale 1ns/10ps

module tst_regfile();

reg clk,regread, regwrite;
reg [3:0] readregsrc1,readregsrc2,readregsrc3,regwritedst;
wire [15:0] a,b,c;
reg [15:0] writedata;
reg [15:0] regfile[0:15];

regfile uut (a,b,c,regread,regwrite,readregsrc1,readregsrc2,readregsrc3,regwritedst,writedata,clk);

initial
begin
#00 clk <= 1'b1;
forever #50 clk <= ~ clk ;
end

initial
begin
#00 regread <= 1'b1;
forever #100 regread <= ~ regread ;
end

always@(regread)
begin
regwrite <= ~ regread; 
end 

initial
begin 
  readregsrc1 <= 4'd0;
  readregsrc2 <= 4'd1;
  readregsrc3 <= 4'd2;
  repeat( 4 ) 
  begin 
     #200 readregsrc1 <= readregsrc1 + 4'd3 ; readregsrc2 <= readregsrc2+4'd3; readregsrc3 <= readregsrc3 +4'd3;
	end 
 end 

initial 
begin 	
	#1000 regwritedst <= 4'b000;	writedata <= 16'habcd; readregsrc1 <= 4'bxxx; readregsrc2 <= 4'bxxx; readregsrc3 <= 4'bxxx;
	repeat(15)
		begin
			#200 writedata <= writedata - 16'b1; regwritedst <= regwritedst + 4'b1;
		end
end 

initial
begin 
 #4200 readregsrc1 <= 4'd0; readregsrc2 <= 4'd1; readregsrc3 <= 4'd2;
  repeat( 4 ) 
  begin 
     #200 readregsrc1 <= readregsrc1 + 4'd3 ; readregsrc2 <= readregsrc2+4'd3; readregsrc3 <= readregsrc3 +4'd3;
	end 
 end 

initial
begin
$dumpfile("ram_64B.vcd");
$dumpvars;
end

initial #12800 $finish;


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
		else if(regwrite) regfile[regwritedst] <= writedata;
		else;
	end
endmodule 
