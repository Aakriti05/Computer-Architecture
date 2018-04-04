 `timescale 1ns/10ps


module tb_comb_reg_sel();

endmodule
 
module comb_log_reg_sel(ReadRegSrc1, ReadRegSrc2, ReadRegSrc3, ReadRegSrc4, opcode, func);
	
//declare i/p and o/p
output reg ReadRegSrc1, ReadRegSrc2, ReadRegSrc3, ReadRegSrc4;
input [3:0] opcode;
input [1:0] func;

//parameterising opcode
parameter addreg 		= 4'b1000;
parameter addseimd		= 4'b1001;
parameter addzeimd		= 4'b1010;	// add a and b  
parameter subreg 		= 4'b1100;	
parameter subseimd 		= 4'b1101;
parameter subzeimd 		= 4'b1110;	// sub a and b
parameter shift 		= 4'b0000;	// shift a by b bit
parameter lnand 		= 4'b1011;	
parameter lnandimd 		= 4'b0111;	// nand a and b 
parameter lor			= 4'b1111; 	
parameter lorimd 		= 4'b0110;   // or a and b
parameter brncheq 		= 4'b0100;   // add a and b shifted by 1 bit 
parameter brnchneq 		= 4'b0101;   // add a and b shifted by 1 bit 
parameter jmp	 		= 4'b0011;   // add a and b shifted by 1 bit 
parameter lwd	 		= 4'b0001;   // add a and b shifted by 1 bit 
parameter strwd 		= 4'b0010;   // add a and b shifted by 1 bit 

// parameterising func field
parameter shl 			= 2'b01;	// shift left a by b bit
parameter shr 			= 2'b10;	// shift right a by b bit
parameter sar 			= 2'b11;	// arthimetic shift a by b bits 

always @(opcode,func)
begin
	case(opcode)
		addreg   :	begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		addseimd :  begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		addzeimd :  begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		subreg	 :  begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		subseimd :  begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		subzeimd : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		shift	 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b1;
					end
		lnand	 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		lnandimd : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		lor		 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		lorimd	 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		brncheq	 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		brnchneq : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
		jmp		 : begin
						ReadRegSrc1 = 1'bx;		//technically dont care
						ReadRegSrc2 = 1'bx;		//technically dont care
						ReadRegSrc3 = 1'bx;		//technically dont care
						ReadRegSrc4 = 1'b0;
					end
		lwd		 : begin
						ReadRegSrc1 = 1'b1;		
						ReadRegSrc2 = 1'b1;
						ReadRegSrc3 = 1'b1;
						ReadRegSrc4 = 1'b0;
					end
		strwd 	 : begin
						ReadRegSrc1 = 1'b1;		
						ReadRegSrc2 = 1'b1;
						ReadRegSrc3 = 1'b1;
						ReadRegSrc4 = 1'b0;
					end
		default  : begin
						ReadRegSrc1 = 1'b0;
						ReadRegSrc2 = 1'b0;
						ReadRegSrc3 = 1'b0;
						ReadRegSrc4 = 1'b0;
					end
	endcase 
end
endmodule 

