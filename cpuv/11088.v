module ddr3_fb(
    input wire clk, 
    input wire rst, 
    input wire mig_ready_i, 
    output wire mig_cmd_clk, 
    output wire mig_cmd_en, 
    output wire [2:0] mig_cmd_instr, 
    output wire [5:0] mig_cmd_bl, 
    output wire [29:0] mig_cmd_byte_addr, 
    input wire mig_cmd_empty, 
    input wire mig_cmd_full, 
    output wire mig_wr_clk, 
    output wire mig_wr_en, 
    output wire [3:0] mig_wr_mask, 
    output wire [31:0] mig_wr_data, 
    input wire mig_wr_full, 
    input wire mig_wr_empty, 
    input wire [6:0] mig_wr_count, 
    input wire mig_wr_underrun, 
    input wire mig_wr_error, 
    output wire mig_rd_clk, 
    output wire mig_rd_en, 
    input wire [31:0] mig_rd_data, 
    input wire mig_rd_full, 
    input wire mig_rd_empty, 
    input wire [6:0] mig_rd_count, 
    input wire mig_rd_overflow, 
    input wire mig_rd_error, 
    input wire [8:0] x_i, 
    input wire [6:0] y_i, 
    input wire in_hsync_i, 
    input wire in_vsync_i, 
    input wire pop_i, 
    output wire [5:0] r_o, 
    output wire [5:0] g_o, 
    output wire [5:0] b_o, 
    output wire ack_o); 