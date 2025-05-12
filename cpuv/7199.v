module is a super-weapon for timing fix,
  assign i_rdy = fifo_i_rdy;
  wire byp = i_vld & o_rdy & (~fifo_o_vld);
  assign fifo_o_rdy = o_rdy;
  assign o_vld = fifo_o_vld | i_vld;
  assign o_dat = fifo_o_vld ? fifo_o_dat : i_dat;
  assign fifo_i_dat  = i_dat;
  assign fifo_i_vld = i_vld & (~byp);
endmodule