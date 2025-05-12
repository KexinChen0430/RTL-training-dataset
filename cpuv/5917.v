module reg_slice (
  vo_regs,
  io_success, vio_tbus,
  i_clk, i_rstb, i_ena, vi_regs, i_step, i_rd, i_wr
  );
  parameter DWIDTH = 16;  
  input         i_clk; 
  input         i_rstb; 
  input         i_ena; 
  input [DWIDTH-1:0]   vi_regs; 
  output [DWIDTH-1:0]  vo_regs; 
  input         i_step; 
  input         i_rd; 
  input         i_wr; 
  inout         io_success; 
  inout [DWIDTH-1:0]   vio_tbus; 
  wire          ena_sync, rd_sync, wr_sync, step_sync;
  negedge_sync ena_synchro(.i_clk(i_clk), .i_async(i_ena),
               .o_sync(ena_sync));
  negedge_sync rd_synchro(.i_clk(i_clk), .i_async(i_rd),
              .o_sync(rd_sync));
  negedge_sync wr_synchro(.i_clk(i_clk), .i_async(i_wr),
              .o_sync(wr_sync));
  negedge_sync step_synchro(.i_clk(i_clk), .i_async(i_step),
                .o_sync(step_sync));
  wire          clk_pulse;
  wire          clk_regs = ena_sync ? i_clk : clk_pulse;
  reg           r_wr_prev, r_wr_pprev, r_step_prev;
  wire          clk_pulse_wr, clk_pulse_step;
  always @( posedge i_clk or negedge i_rstb ) begin : main_clk_reg
    if ( !i_rstb ) begin
      r_wr_prev <= 0;
      r_wr_pprev <= 0;
      r_step_prev <= 0;
    end
    else begin
      r_wr_prev <= wr_sync;
      r_wr_pprev <= r_wr_prev;
      r_step_prev <= step_sync;
    end
  end 
  assign clk_pulse_wr = r_wr_prev && !r_wr_pprev;
  assign clk_pulse_step = step_sync && !r_step_prev;
  assign clk_pulse = wr_sync ? clk_pulse_wr : clk_pulse_step;
  reg           r_rd_prev;
  wire          clk_pulse_rd;
  always @( posedge i_clk or negedge i_rstb ) begin : shadow_clk_reg
    if ( !i_rstb )
      r_rd_prev <= 0;
    else
      r_rd_prev <= rd_sync;
  end
  assign clk_pulse_rd = rd_sync && !r_rd_prev;
  reg [DWIDTH-1:0]  rv_shadow;
  always @( posedge clk_pulse_rd or negedge i_rstb ) begin : shadow_reg
    if ( !i_rstb )
      rv_shadow <= 0;
    else
      rv_shadow <= vo_regs;
  end
  assign vio_tbus = (rd_sync && i_rd) ? rv_shadow : {DWIDTH{1'bz}};
  reg [DWIDTH-1:0]  vo_regs;
  wire [DWIDTH-1:0] v_regs_pre;
  assign v_regs_pre = ( !ena_sync && wr_sync ) ? vio_tbus : vi_regs;
  always @( posedge clk_regs or negedge i_rstb ) begin : main_reg
    if ( !i_rstb )
      vo_regs <= 0;
    else
      vo_regs <= v_regs_pre;
  end
  wire pre_io_success = r_rd_prev || ( !ena_sync && r_wr_pprev );
  assign io_success = ( i_rd || i_wr ) ? pre_io_success : 1'bz;
endmodule