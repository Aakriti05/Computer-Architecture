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

//test bench module
module tb_test_int();

endmodule
 

//top module for integration 
module test_int();
//declare inputs and outputs

//declare required wires
wire [14:0] pcaddout;
wire [14:0] pcaddinp;
wire PCWrite;
wire IntMemRead;
wire [15:0] instr, dout_temp,ALUInp1,ALUInp2,ALUSrc1_inp3;
wire IRRead,IRWrite;
wire ReadRegSrc1,ReadRegSrc2,ReadRegSrc3;
wire [1:0] ALUSrc1,ALUSrc2;
wire [3:0] append10regadd,append11regadd;
wire [3:0] readreg1,readreg2,readreg3;

//instantiate modules
FSM controlsignal(ALUSrc1, ALUSrc2, ALUop, IntMemRead, PCWrite, PCWriteCond, FlagSel, IRWrite, PCSrc, IRRead, RegRead, Muxgrp, MemtoReg, RegWrite, MemRead, MemWrite, clk, rst, op, func);
pcreg pcreg(pcaddout,pcaddinp,PCWrite);
instr_mem_16kB instr_mem(dout_temp,clk,IntMemRead,pcaddout);
intreg intreg(instr,dout_temp,IRWrite,IRRead);
extend_4_to_16 ex4to6(ALUSrc1_inp3,instr[7:4]);
comb_log_reg_sel muxex_sel(ReadRegSrc1, ReadRegSrc2, ReadRegSrc3, instr[15:12], instr[1:0]);

//reg append
append10 append10(append10regadd,instr[9:8]);
append11 append11(append11regadd,instr[11:10]); 

//register file muxes
mux_2to1 mux_RegSrc1(readreg1,instr[11:8],append10regadd,ReadRegSrc1);
mux_2to1 mux_RegSrc2(readreg2,instr[3:0],readreg1,ReadRegSrc2);
mux_2to1 mux_RegSrc3(readreg3,instr[11:8],append11regadd,ReadRegSrc3);
mux_2to1 mux_MemtoReg(writedata,,,MemtoReg);

//register file
regfile regfile(a,b,c,regread,regwrite,readregsrc1,readregsrc2,readregsrc3,regwritedst,writedata,clk);

//alusrc muxes
//mux_4to1 mux_ALUSrc1(ALUInp1,pcaddout,,,ALUSrc1_inp3,ALUSrc1);
//mux_4to1 mux_ALUSrc2(ALUInp2,,15'h0002,,,ALUSrc2);

endmodule 

