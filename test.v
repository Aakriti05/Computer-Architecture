`timescale 1ns/10ps

`include "FSM.v"
`include "alu_16bit.v"
`include "memry.v"
`include "mux_4to1.v"
`include "mux_2to1.v"
`include "regfile.v"
`include "comb_log_reg_selx.v"
`include "ext_12to16.v"
`include "ext_8to16.v"
`include "ext_4to16.v"
`include "pcreg.v"
`include "intreg.v"
`include "append.v"
`include "mdr.v"

//test bench module
module tb_test_int();

reg clk,rst;

test uut(clk,rst);
reg dout_temp;
initial 
begin 
		#00 clk <= 1'b0 ; 
forever #05 clk <= ~clk ; 
end

initial 
begin
	#00 rst = 1'b1;
	#05 rst = 1'b0;
	#100 $finish;
end

initial 
begin 
	$monitor("time=%3d, out=%15h",$time,dout_temp);
end


initial
begin
$dumpfile("test.vcd");
$dumpvars;
end

endmodule
 

//top module for integration 
module test(clk,rst);
//declare inputs and outputs
input clk,rst;

//declare required wires
wire [15:0] pcaddout;
wire [15:0] pcaddinp;
wire PCWrite;
wire IntMemRead;
wire [15:0] instr, dout_temp,ALUInp1,ALUInp2,ALUSrc1_inp3,ALUSrc2_inp2,ALUSrc2_inp3,a,b,c;
wire IRRead,IRWrite;
wire ReadRegSrc1,ReadRegSrc2,ReadRegSrc3;
wire [1:0] ALUSrc1,ALUSrc2;
wire [3:0] append10regadd,append11regadd;
wire [3:0] readregsrc1,readregsrc2,readregsrc3;
wire [15:0] writedata;
wire ExOp;
wire [2:0] ALUop;
wire [15:0] ALUOut,data,data_temp;

//instantiate modules
FSM controlsignal(ALUSrc1, ALUSrc2, ALUop, Resetzero, IntMemRead, PCWrite, PCWriteCond, FlagSel, IRWrite, PCSrc, IRRead, RegRead, MemtoReg, ExOp, RegWrite, MemRead, MemWrite, clk, rst, instr[15:12], instr[3:0]);
pcreg pcreg(pcaddout[14:0],pcaddinp[14:0],pc_write, Resetzero);
comb_log_reg_sel muxex_sel(ReadRegSrc1, ReadRegSrc2, ReadRegSrc3, instr[15:12], instr[1:0]);

//memory (instr and data)
instr_mem_16kB instr_mem(dout_temp,clk,IntMemRead,pcaddout[14:0]);
intreg intreg(instr,dout_temp,IRWrite,IRRead);
data_mem_16kB data_mem(data_temp,clk,MemRead,MemWrite,c,ALUOut[14:0]);
mdr mdr(data,data_temp);

//extend to 16
extend_4_to_16 ex4to6(ALUSrc1_inp3,instr[7:4]);
extend_8_to_16 ex8to6(ALUSrc2_inp2,instr[7:0],ExOp);
extend_12_to_16 ex12to6(ALUSrc2_inp3,instr[11:0]);

//reg append
append10 append10(append10regadd,instr[9:8]);
append11 append11(append11regadd,instr[11:10]); 

//register file muxes
mux_2to1 mux_RegSrc1(readregsrc1,instr[11:8],append10regadd,ReadRegSrc1); //4 bit mux
mux_2to1 mux_RegSrc2(readregsrc2,instr[3:0],readregsrc1,ReadRegSrc2); //4 bit mux
mux_2to1 mux_RegSrc3(readregsrc3,instr[11:8],append11regadd,ReadRegSrc3); //4 bit mux
mux_2to1_16bit mux_MemtoReg(writedata,data,ALUOut,MemtoReg);

//register file
regfile regfile(a,b,c,RegRead,RegWrite,readregsrc2,instr[7:4],readregsrc3,readregsrc3,writedata,clk);

//alusrc muxes
mux_4to1 mux_ALUSrc1(ALUInp1,pcaddout,a,c,ALUSrc1_inp3,ALUSrc1);
mux_4to1 mux_ALUSrc2(ALUInp2,b,16'h0002,ALUSrc2_inp2,ALUSrc2_inp3,ALUSrc2);

//ALU
alu_16bit alu(zerof,ALUOut,ALUInp1,ALUInp2,ALUop);

//zerof mux
mux_2to1_zerof mux_zerof(flag,zerof,FlagSel);

//conditional for pcwrite
and a1(temp_out,flag,PCWriteCond);
or a2(pc_write,PCWrite,temp_out);

//pc mux
mux_2to1_16bit pcmux(pcaddinp,ALUOut,c,PCSrc);
endmodule 

