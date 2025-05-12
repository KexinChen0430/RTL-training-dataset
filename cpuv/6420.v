module unnamed_module; 
assign attr_io_hit = dec_3c0 | dec_3c1 | c_cr24_rd | c_cr26_rd;
assign rd_or_wr = h_iowr | h_iord;
always @(posedge h_hclk or negedge h_reset_n)
  if (!h_reset_n) rd_or_wr_d <= 1'b0; 
  else            rd_or_wr_d <= rd_or_wr; 
assign a_ready_n = (~(rd_or_wr_d & attr_io_hit) );
endmodule 