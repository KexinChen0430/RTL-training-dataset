module 
always @(posedge clk) 
  if (!resetn) 
    wr_wrd_cntr_r <= 8'h00; 
  else if (dbg_wr_sts_vld) 
    wr_wrd_cntr_r <= wr_wrd_cntr; 
always @(posedge clk) 
  if (!resetn) 
    rd_wrd_cntr_r <= 8'h00; 
  else if (dbg_rd_sts_vld) 
    rd_wrd_cntr_r <= rd_wrd_cntr; 
always @(posedge clk) 
  if (wrd_cntr_rst) 
    rd_mismatch_wrd_cntr_r <= 8'h00; 
  else if (~data_msmatch_err_dbg) 
    rd_mismatch_wrd_cntr_r <= rd_wrd_cntr - 1; 
assign dbg_wr_sts = {rd_wrd_cntr_r, 11'h0, data_pattern, write_err_dbg, cmd_err_dbg, wdata_sts_r}; 
assign dbg_rd_sts = {wr_wrd_cntr_r, 2'b00, data_pattern, rd_mismatch_wrd_cntr_r, data_msmatch_err_dbg, read_err_dbg, cmd_err_dbg, rdata_sts_r}; 
assign test_cmptd = tg_state[TG_UPDT_CNTR] & next_tg_state[TG_IDLE]; 
assign write_cmptd = (tg_state[TG_WR_DATA] | tg_state[TG_WR_DONE]) & 
                     (next_tg_state[TG_GEN_PRBS] | next_tg_state[TG_UPDT_CNTR]); 
assign read_cmptd = tg_state[TG_RD_DATA] & (next_tg_state[TG_GEN_PRBS] | next_tg_state[TG_UPDT_CNTR]); 
assign cmp_data_en = dgen_en & tg_state[TG_RD_DATA]; 
assign rdata_cmp  = rdata; 
always @(*) begin 
  if (test_cmptd) begin 
    $display ("[INFO] : All tests have been completed"); 
    if (cmd_err)
      $display ("[ERROR] Command error has occurred"); 
    if (data_msmatch_err)
      $display ("[ERROR] Data mismatch error occurred"); 
    if (write_err)
      $display ("[ERROR] Timeout occurred during write transaction"); 
    if (read_err)
      $display ("[ERROR] Timeout occurred during read transaction"); 
    if (!cmd_err & !data_msmatch_err & !write_err & !read_err)
      $display ("[INFO] : Tests PASSED"); 
    $finish; 
  end
end
endmodule 