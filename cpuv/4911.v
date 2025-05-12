input  rst_n, clk_100, zlp_mode_selected, i_gpif_in_ch0_rdy_d, i_gpif_out_ch0_rdy_d;
output o_gpif_we_n_zlp_, o_gpif_pkt_end_n_zlp_, [31:0] data_out_zlp;
reg [2:0] current_zlp_state, next_zlp_state;
parameter [2:0] zlp_idle = 3'd0, zlp_wait_flagb = 3'd1, zlp_write = 3'd2, zlp_write_wr_delay = 3'd3, zlp_wait = 3'd4;
reg [3:0] strob_cnt;
reg strob;
reg [31:0] data_gen_zlp;
reg o_gpif_pkt_end_n_;
...