
module my_module(input  [31:0] bb_sample,
                 output bb_strobe);

  assign frontend_i = duc_out_i;
  assign frontend_q = duc_out_q;
  assign duc_in_sample = bb_sample;
  assign bb_strobe = duc_in_strobe;
  assign duc_in_enable = enable;
endmodule

