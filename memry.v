`timescale 1ns/10ps

module tb_memory();
//testbench for memory

endmodule



module instr_mem_16kB(dout,clk,rb,adrb);

input clk,rb;
input [14:0]adrb;
output reg [15:0]dout;
reg [7:0] memory[0:16383];

initial $readmemh("instr_64.txt",memory);

always@(negedge clk)
	begin
		if(rb) dout <= {memory[adrb],memory[adrb+15'b1]};
		else; 
	end
endmodule

module data_mem_16kB(dout,clk,rb,wb,din,adrb);

output reg [15:0] dout;
input clk,rb,wb;
input [14:0] adrb;
input [15:0] din;
reg [7:0] memory[0:16383];

initial $readmemh("data_64.txt",memory);

always@(negedge clk)
	begin
		if(rb) dout <= {memory[adrb],memory[adrb+15'b1]};
		if(wb) begin 
						memory[adrb] <= din[15:8];
						memory[adrb+15'b01] <= din[7:0];
					end 
		else;
		$writememh("data_64_2.txt",memory);		
	end
endmodule