module ALU (
	ALU_result,
	A,
	B,
	opcode,
	reg_HMULT,
	reg_MSR,
	reg_MSR_next,
	reg_HMULT_next
);
	`include "definition/Definition.v"
	output		reg		[WORD-1:0]								ALU_result;
	input				[WORD-1:0]								A;
	input				[WORD-1:0]								B;
	input				[ALU_OPCODE_WIDTH-1:0]					opcode;
	input				[WORD-1:0]								reg_HMULT;
	input				[WORD-1:0]								reg_MSR;
	output		reg		[WORD-1:0]								reg_MSR_next;
	output		reg		[WORD-1:0]								reg_HMULT_next;
				reg		[(2*WORD)-1:0]							interword;
				reg												hmultop;
				reg		[(2*WORD)-1:0]							carryword;
	always @(*) begin
		case(opcode)
			ALU_ADD_0		:	begin	interword	<=	 ( A)+( B)						;	end
			ALU_ADD_1		:	begin	interword	<=	 ( A)+( B)  + reg_MSR[BIT_MSR_C];	end
			ALU_ADD_2		:	begin	interword	<=	 ( A)+(-B)						;	end
			ALU_ADD_3		:	begin	interword	<=	 ( A)+(~B)  + reg_MSR[BIT_MSR_C];	end
			ALU_ADD_4		:	begin	interword	<=	 (-A)+( B)						;	end
			ALU_ADD_5		:	begin	interword	<=	 (~A)+( B)  + reg_MSR[BIT_MSR_C];	end
			ALU_ADD_6		:	begin	interword	<=	 (-A)+(-B)						;	end
			ALU_ADD_7		:	begin	interword	<=	 (~A)+(~B)  + reg_MSR[BIT_MSR_C];	end
			ALU_AND_0		:	begin	interword	<=	 ( A& B);							end
			ALU_AND_1		:	begin	interword	<=	 ( A&~B);							end
			ALU_AND_2		:	begin	interword	<=	 (~A& B);							end
			ALU_AND_3		:	begin	interword	<=	 (~A&~B);							end
			ALU_AND_4		:	begin	interword	<=	~( A& B);							end
			ALU_AND_5		:	begin	interword	<=	~( A&~B);							end
			ALU_AND_6		:	begin	interword	<=	~(~A& B);							end
			ALU_AND_7		:	begin	interword	<=	~(~A&~B);							end
			ALU_XOR_0		:	begin	interword	<=	A^B;								end
			ALU_XOR_1		:	begin	interword	<=	~(A^B);								end
			ALU_VAND_0		:	begin	interword	<=	&B;									end
			ALU_VAND_1		:	begin	interword	<=	!(&B);								end
			ALU_VOR_0		:	begin	interword	<=	|B;									end
			ALU_VOR_1		:	begin	interword	<=	!(|B);								end
			ALU_VXOR_0		:	begin	interword	<=	^B;									end
			ALU_VXOR_1		:	begin	interword	<=	!(^B);								end
			ALU_LHI			:	begin	interword	<=	(A<<(WORD/2)) | B;					end
			ALU_LLI			:	begin	interword	<=	A | (B<<(WORD/2));					end
			ALU_IDENTITY_A	:	begin	interword	<=	A;								end
			ALU_IDENTITY_B	:	begin	interword	<=	B;								end
			default			:	begin	interword	<=	A;								end
		endcase
		carryword							<= A ^ B ^ interword;
		reg_MSR_next[WORD-1:BIT_MSR_UNOCC]	<=	0;
		reg_MSR_next[BIT_MSR_Z]				<=	!(|interword);
		reg_MSR_next[BIT_MSR_C]				<=	interword[WORD];
		reg_MSR_next[BIT_MSR_V]				<=	carryword[WORD] ^ carryword[WORD-1];
		reg_MSR_next[BIT_MSR_N]				<=	interword[WORD-1];
		reg_MSR_next[BIT_MSR_M]				<=	(interword[(2*WORD)-1:WORD] != 0) && (interword[(2*WORD)-1:WORD] != -1) && hmultop;
		ALU_result							<= interword[WORD-1:0];
		if(
			(opcode == ALU_MULT_0) ||
			(opcode == ALU_MULT_1) ||
			(opcode == ALU_DIV_0) ||
			(opcode == ALU_DIV_1)
		) begin
			reg_HMULT_next	<= 0;
			hmultop <= 1;
		end else begin
			reg_HMULT_next	<= reg_HMULT;
			hmultop <= 0;
		end
	end
endmodule