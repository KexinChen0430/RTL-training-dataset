module here.
  always @(posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)
      cur_addr <= 17'b0;
    else if (sync_c_crt_line_end | sync_pre_vde)
      cur_addr <= row_beg_saddr;
    else if (crt_ff_write)
      cur_addr <= cur_addr + 1;
  end
  assign cur_loc_value = {reg_cr0e_qout[7:0], reg_cr0f_qout[7:0]};
  assign cursorx = (cur_loc_value == {cur_addr[16:4], cur_addr[2:0]});
endmodule