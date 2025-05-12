module Splitter	( 
	instruction, 
	fld_opcode, 
	fld_affect, 
	fld_field0, 
	fld_field1, 
	fld_field2, 
	fld_shift_type, 
	fld_shift_IR, 
	fld_shamt_S, 
	fld_shamt_I, 
	fld_shamt_R, 
	fld_immediate 
);
	`include "definition/Definition.v" 
	input		 		[WORD-1				:0]	instruction; 
	output		reg		[WIDTH_OPCODE-1		:0]	fld_opcode; 
	output		reg		[WIDTH_AFFECT-1		:0]	fld_affect; 
	output		reg		[WIDTH_FIELD0-1		:0]	fld_field0; 
	output		reg		[WIDTH_FIELD1-1		:0]	fld_field1; 
	output		reg		[WIDTH_FIELD2-1		:0]	fld_field2; 
	output		reg		[WIDTH_SHIFT_TYPE-1	:0]	fld_shift_type; 
	output		reg		[WIDTH_SHIFT_IR-1	:0]	fld_shift_IR; 
	output		reg		[WIDTH_SHAMT_S-1	:0]	fld_shamt_S; 
	output		reg		[WIDTH_SHAMT_I-1	:0]	fld_shamt_I; 
	output		reg		[WIDTH_SHAMT_R-1	:0]	fld_shamt_R; 
	output		reg		[WIDTH_IMMEDIATE-1	:0]	fld_immediate; 
	always @(*) begin 
		fld_opcode		<=	instruction[VECT_OPCODE_H		:VECT_OPCODE_L]; 
		fld_affect		<=	instruction[VECT_AFFECT_H		:VECT_AFFECT_L]; 
		fld_field0		<=	instruction[VECT_FIELD0_H		:VECT_FIELD0_L]; 
		fld_field1		<=	instruction[VECT_FIELD1_H		:VECT_FIELD1_L]; 
		fld_field2		<=	instruction[VECT_FIELD2_H		:VECT_FIELD2_L]; 
		fld_shift_type	<=	instruction[VECT_SHIFT_TYPE_H	:VECT_SHIFT_TYPE_L]; 
		fld_shift_IR	<=	instruction[VECT_SHIFT_IR_H		:VECT_SHIFT_IR_L]; 
		fld_shamt_S		<=	instruction[VECT_SHAMT_S_H		:VECT_SHAMT_S_L]; 
		fld_shamt_I		<=	instruction[VECT_SHAMT_I_H		:VECT_SHAMT_I_L]; 
		fld_shamt_R		<=	instruction[VECT_SHAMT_R_H		:VECT_SHAMT_R_L]; 
		fld_immediate	<=	instruction[VECT_IMMEDIATE_H	:VECT_IMMEDIATE_L]; 
	end
endmodule 