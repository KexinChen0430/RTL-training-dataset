module. 
  reg io_config_rd_r; 
  reg io_config_rd_r1; 
  wire io_config_rd_delayed; 
  always @(posedge clk) begin 
    io_config_rd_r  <= io_config_rd; 
    io_config_rd_r1 <= io_config_rd_r; 
  end
  assign io_config_rd_delayed = (CWL >= 7) ? io_config_rd_r1: io_config_rd_r; 
  wire maint_clear = ~maint_idle_lcl && ~|maint_hit_busies_ns; 
  reg force_io_config_rd_r_lcl; 
  wire force_io_config_rd_ns = maint_clear && maint_zq_r && ~io_config_rd && ~force_io_config_rd_r_lcl; 
  always @(posedge clk) force_io_config_rd_r_lcl <= #TCQ force_io_config_rd_ns; 
  assign force_io_config_rd_r = force_io_config_rd_r_lcl; 
  wire maint_rdy = maint_clear && (~maint_zq_r || io_config_rd_delayed); 
  reg maint_rdy_r1; 
  always @(posedge clk) maint_rdy_r1 <= #TCQ maint_rdy; 
  assign start_maint = maint_rdy && ~maint_rdy_r1; 
  end 
endgenerate
input [7:0] slot_0_present; 
input [7:0] slot_1_present; 
reg insert_maint_r_lcl; 
output wire insert_maint_r; 
assign insert_maint_r = insert_maint_r_lcl; 
generate begin : generate_maint_cmds
  reg [RANK_WIDTH:0] present_count; 
  wire [7:0] present = slot_0_present | slot_1_present; 
  always @(present) begin 
    present_count = {RANK_WIDTH{1'b0}}; 
    for (i=0; i<8; i=i+1) 
      present_count = present_count + {{RANK_WIDTH{1'b0}}, present[i]};
  end
  reg [RANK_WIDTH:0] send_cnt_ns; 
  reg [RANK_WIDTH:0] send_cnt_r; 
  always @(maint_zq_r or present_count or rst or send_cnt_r or start_maint) 
    if (rst) send_cnt_ns = 4'b0; 
    else begin
      send_cnt_ns = send_cnt_r; 
      if (start_maint && maint_zq_r) send_cnt_ns = present_count; 
      if (|send_cnt_ns) 
        send_cnt_ns = send_cnt_ns - ONE[RANK_WIDTH-1:0]; 
    end
  always @(posedge clk) send_cnt_r <= #TCQ send_cnt_ns; 
  wire insert_maint_ns = start_maint || |send_cnt_r; 
  always @(posedge clk) insert_maint_r_lcl <= #TCQ insert_maint_ns; 
end 
endgenerate
localparam nRFC_CLKS = (nCK_PER_CLK == 1) ? nRFC : ((nRFC/2) + (nRFC%2)); 
localparam nZQCS_CLKS = (nCK_PER_CLK == 1) ? tZQCS : ((tZQCS/2) + (tZQCS%2)); 
localparam RFC_ZQ_TIMER_WIDTH = (nZQCS_CLKS > nRFC_CLKS) ? clogb2(nZQCS_CLKS + 1) : clogb2(nRFC_CLKS + 1); 
localparam THREE = 3; 
generate begin : rfc_zq_timer
  reg [RFC_ZQ_TIMER_WIDTH-1:0] rfc_zq_timer_ns; 
  reg [RFC_ZQ_TIMER_WIDTH-1:0] rfc_zq_timer_r; 
  always @(insert_maint_r_lcl or maint_zq_r or rfc_zq_timer_r or rst) begin 
    rfc_zq_timer_ns = rfc_zq_timer_r; 
    if (rst) rfc_zq_timer_ns = {RFC_ZQ_TIMER_WIDTH{1'b0}}; 
    else if (insert_maint_r_lcl) rfc_zq_timer_ns = maint_zq_r ? nZQCS_CLKS : nRFC_CLKS; 
    else if (|rfc_zq_timer_r) rfc_zq_timer_ns = rfc_zq_timer_r - ONE[RFC_ZQ_TIMER_WIDTH-1:0]; 
  end
  always @(posedge clk) rfc_zq_timer_r <= #TCQ rfc_zq_timer_ns; 
  assign maint_end = (rfc_zq_timer_r == THREE[RFC_ZQ_TIMER_WIDTH-1:0]); 
end 
endgenerate
endmodule