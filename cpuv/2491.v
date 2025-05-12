module mask_to_zero(
    input clk, 
    input [14:0] data_in, 
    input [5:0] lz_pos, 
    output [14:0] data_out 
    );