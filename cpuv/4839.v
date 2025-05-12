module map_table(
    output [5:0] p_rs, p_rt, 
    output p_rs_v, p_rt_v, 
    output [5:0] PR_old_rd, 
    input clk, rst, 
    input hazard_stall, 
    input isDispatch, 
    input [4:0] l_rs, l_rt, l_rd, 
    input RegDest, 
    input [5:0] p_rd_new, 
    input [4:0] recover_rd, 
    input [5:0] p_rd_flush, 
    input recover, 
    input RegDest_ROB, 
    input [5:0] p_rd_compl, 
    input complete, 
    input RegDest_compl 
);