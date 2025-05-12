module ctrl_unit #(parameter word_sz=8, op_sz=4, state_sz=4, src_sz=2, dst_sz=2, sel1_sz=3, sel2_sz=2) 
(	output reg load_r0, load_r1, load_r2, load_r3, load_pc, 
	inc_pc, 
	output [sel1_sz-1:0] bus1_sel_mux, 
	output [sel2_sz-1:0] bus2_sel_mux, 
	output reg load_ir, load_add_r, load_reg_y, load_reg_z, 
	output reg write, io_write, 
	input [word_sz-1:0] instr, 
	input zero, 
	input clk, rst); 