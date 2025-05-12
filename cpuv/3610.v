module bsg_counter_clear_up_one_hot
  #(parameter `BSG_INV_PARAM(max_val_p), width_lp=max_val_p+1, init_val_p=(width_lp) ' (1))
  (input clk_i
   ,input reset_i
   ,input clear_i
   ,input up_i
   ,output [width_lp-1:0] count_r_o
  );
  logic [width_lp-1:0] bits_r, bits_n;
  always_comb
    begin
      bits_n   = bits_r;
      if (clear_i)
        bits_n = (width_lp) ' (1);
      if (up_i)
        bits_n = { bits_n[width_lp-2:0], bits_n[width_lp-1] };
      if (reset_i)
        bits_n = (width_lp) ' (init_val_p);
    end
  always_ff @(posedge clk_i)
    if (reset_i | up_i | clear_i)
        bits_r <= bits_n;
  assign count_r_o = bits_r;
endmodule