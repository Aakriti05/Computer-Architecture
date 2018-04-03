`timescale 1ns/10ps

//test bench module
module tb_mdr();

endmodule

module mdr(data_out,data_in);
//declare inputs and outputs
output reg [15:0] data_out;
input [15:0] data_in;

always @(*)
begin
	data_out = data_in;
end
endmodule 

