`timescale 1ns/10ps 
module tb_FSM();
 
endmodule

module FSM (ALUSrc1, ALUSrc2, ALUop, Resetzero, IntMemRead, PCWrite, PCWriteCond, FlagSel, IRWrite, PCSrc, IRRead, RegRead, MemtoReg, ExOp, RegWrite, MemRead, MemWrite, clk, rst, op, func);

	input [3:0]op, func;
	input clk, rst;
	output reg Resetzero, IntMemRead, PCWrite, PCWriteCond, FlagSel, IRWrite, PCSrc, IRRead, RegRead, MemtoReg, ExOp, RegWrite, MemRead, MemWrite;
	output reg [1:0]ALUSrc1, ALUSrc2;
	output reg [2:0]ALUop;

	parameter IF = 5'b00000, ID = 5'b00001, EX_add_reg = 5'b00010, EX_add_sign_imm = 5'b00011, EX_add_zero_imm = 5'b00100, EX_sub_reg = 5'b00101, 
		EX_sub_sign_imm = 5'b00110, EX_sub_zero_imm = 5'b00111, EX_left_lo = 5'b01000, EX_right_lo = 5'b01001, EX_right_ar = 5'b01010, 
		EX_nand_reg = 5'b01011, EX_or_reg = 5'b01100, EX_nand_imm = 5'b01101, EX_or_imm = 5'b01110, 
		EX_bch_eq = 5'b01111, EX_bch_noteq = 5'b10000, EX_jmp = 5'b10001, EX_load_store = 5'b10010, 
		MEM_load = 5'b10011, MEM_store = 5'b10100, WB_load = 5'b10101; 
	reg [2:0]NextState, CurrentState;

	// To update the state	
	always @(posedge clk)
	begin 
		if(rst)
		begin
		CurrentState <= IF; 
		Resetzero <= 1'b1;
		end
		else    CurrentState <= NextState;
	end

	//To calculate the next state
	always @(*)
	begin 
	case(CurrentState)
	IF   :begin 
		NextState <= ID;
		end
	ID   :begin 
		if(op == 4'b1000) NextState <= EX_add_reg; 
		else if(op == 4'b1001) NextState <= EX_add_sign_imm;
		else if(op == 4'b1010) NextState <= EX_add_zero_imm;
		else if(op == 4'b1100) NextState <= EX_sub_reg;
		else if(op == 4'b1101) NextState <= EX_sub_sign_imm;
		else if(op == 4'b1110) NextState <= EX_sub_zero_imm;
		else if(op == 4'b0000) 
		begin
			if(func == 4'b0001) NextState <= EX_left_lo;
			else if(func == 4'b0010) NextState <= EX_right_lo;
			else if(func == 4'b0011) NextState <= EX_right_ar;
		end
		else if(op == 4'b1011) NextState <= EX_nand_reg;
		else if(op == 4'b1111) NextState <= EX_or_reg;
		else if(op == 4'b0111) NextState <= EX_nand_imm;
		else if(op == 4'b0110) NextState <= EX_or_imm;
		else if(op == 4'b0100) NextState <= EX_bch_eq;
		else if(op == 4'b0101) NextState <= EX_bch_noteq;
		else if(op == 4'b0011) NextState <= EX_jmp;
		else if(op == 4'b0001 || op == 4'b0010) NextState <= EX_load_store;
		else
			NextState <= IF;
		end

	EX_add_reg   :begin 
		    NextState <= IF; 
		    end

	EX_add_sign_imm :begin 
		    NextState <= IF; 
		    end

	EX_add_zero_imm :begin 
		    NextState <= IF; 
		    end

	EX_sub_reg   :begin 
		    NextState <= IF; 
		    end

	EX_sub_sign_imm :begin 
		    NextState <= IF; 
		    end

	EX_sub_zero_imm :begin 
		    NextState <= IF; 
		    end

	EX_left_lo   :begin 
		    NextState <= IF; 
		    end

	EX_right_lo   :begin 
		    NextState <= IF; 
		    end

	EX_right_ar   :begin 
		    NextState <= IF; 
		    end

	EX_nand_reg   :begin 
		    NextState <= IF; 
		    end

	EX_or_reg   :begin 
		    NextState <= IF; 
		    end

	EX_nand_imm   :begin 
		    NextState <= IF; 
		    end

	EX_or_imm   :begin 
		    NextState <= IF; 
		    end

	EX_bch_eq   :begin 
		    NextState <= IF; 
		    end

	EX_bch_noteq   :begin 
		    NextState <= IF; 
		    end

	EX_jmp   :begin 
		    NextState <= IF; 
		    end

	EX_load_store   :begin 
		    if(op == 4'b0001) NextState <= MEM_load;
		    else if(op == 4'b0010) NextState <= MEM_store; 
		    else NextState <= IF ;
		 	end

	MEM_load   :begin 
		    NextState <= WB_load; 
		    end

	MEM_store   :begin 
		    NextState <= IF; 
		    end

	WB_load     :begin 
		    NextState <= IF; 
		    end

	default : NextState <= IF ;
	endcase  
	end

	// Output Calculation in MOORE it is only state dependent
	always @(*)
	begin 
		case(CurrentState)
		IF            : begin
				IntMemRead <= 1'b1; PCWrite <= 1'b1; IRWrite <= 1'b1; PCSrc <= 1'b0; ALUSrc1 <= 2'b00; ALUSrc2 <= 2'b01; ALUop <= 3'b000; MemWrite <= 1'b0;
				end
		ID            : begin
				IRRead <= 1'b1; RegRead <= 1'b1; IRWrite <= 1'b0; IntMemRead <= 1'b0; RegWrite <= 1'b0;
				end
		EX_add_reg    : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b000;
				end
		EX_add_sign_imm : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b000; ExOp <= 1'b0;
				end
		EX_sub_zero_imm : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b000; ExOp <= 1'b1;
				end
		EX_sub_reg    : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b001;
				end
		EX_sub_sign_imm : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b001; ExOp <= 1'b0;
				end
		EX_sub_zero_imm : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b001; ExOp <= 1'b1;
				end
		EX_left_lo    : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b00; ALUop <= 3'b010;
				end
		EX_right_lo   : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b00; ALUop <= 3'b011;
				end
		EX_right_ar   : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b00; ALUop <= 3'b100;
				end
		EX_nand_reg   : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b101;
				end
		EX_or_reg     : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b110;
				end
		EX_nand_imm   : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b101;
				end
		EX_or_imm     : begin
				MemtoReg <= 1'b1; RegWrite <= 1'b1; ALUSrc1 <= 2'b10; ALUSrc2 <= 2'b10; ALUop <= 3'b110;
				end
		EX_bch_eq     : begin
				PCSrc <= 1'b1; PCWriteCond <= 1'b1; PCWrite <= 1'b0; FlagSel <= 1'b0; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b001;
				end
		EX_bch_noteq  : begin
				PCSrc <= 1'b1; PCWriteCond <= 1'b1; PCWrite <= 1'b0; FlagSel <= 1'b1; ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b00; ALUop <= 3'b001;
				end
		EX_jmp        : begin
				PCSrc <= 1'b0; PCWrite <= 1'b1; ALUSrc1 <= 2'b00; ALUSrc2 <= 2'b11; ALUop <= 3'b000;
				end
		EX_load_store : begin
				ALUSrc1 <= 2'b01; ALUSrc2 <= 2'b10; ALUop <= 3'b101;
				end
		MEM_load      : begin
				MemRead <= 1'b1;
				MemWrite <= 1'b0;
				end
		MEM_store     : begin
				MemWrite <= 1'b1;
				MemRead <= 1'b0;
				end
		WB_load       : begin
				MemtoReg <= 1'b0; RegWrite <= 1'b1; MemRead <= 1'b0;
				end
		endcase
	end
	
endmodule