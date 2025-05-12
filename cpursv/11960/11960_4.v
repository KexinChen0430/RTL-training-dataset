
module aurora_64b66b_25p4G_CHANNEL_BOND_GEN  #(parameter  INTER_CB_GAP = 5'd9)
  (CHANNEL_UP,GEN_CH_BOND,USER_CLK,TXDATAVALID_IN,RESET);

  input  CHANNEL_UP;
  output GEN_CH_BOND;
  input  USER_CLK;
  input  TXDATAVALID_IN;
  input  RESET;
  wire free_count_done;
  reg  [0:4]  free_count_r = 5'd0;
  reg  freeze_free_count_r;
  reg  gen_ch_bond_int;

  
  always @(posedge USER_CLK)
      begin
        freeze_free_count_r <= #1 ~TXDATAVALID_IN;
      end
  
  always @(posedge USER_CLK)
      if (RESET) free_count_r <= #1 5'b0;
      else if (freeze_free_count_r) free_count_r <= #1 free_count_r;
      else if (free_count_done) free_count_r <= #1 5'b0;
      else free_count_r <= #1 free_count_r+1'b1;
  assign free_count_done = free_count_r == INTER_CB_GAP;
  
  always @(posedge USER_CLK)
      begin
        gen_ch_bond_int <= #1 free_count_done & !CHANNEL_UP;
      end
  assign GEN_CH_BOND = gen_ch_bond_int;
endmodule

