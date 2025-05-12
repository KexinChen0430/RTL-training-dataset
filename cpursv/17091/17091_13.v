
module round  #(parameter 
       bits_in          = 0,
       bits_out         = 0,
       round_to_zero    = 0,
       round_to_nearest = 1,
       trunc            = 0)
  (input  [bits_in+(0-1):0] in,
   output [bits_out+(0-1):0] out,
   output [(-bits_out)+bits_in:0] err);

  wire 
      round_corr             ,
      round_corr_trunc       ,
      round_corr_rtz         ,
      round_corr_nearest     ,
      round_corr_nearest_safe;

  assign round_corr_trunc = 0;
  assign round_corr_rtz = in[bits_in+(0-1)] & |in[((-bits_out)+bits_in)+(0-1):0];
  assign round_corr_nearest = in[((-bits_out)+bits_in)+(0-1)];
  
  generate
      if (((-bits_out)+bits_in) > 1) 
        assign round_corr_nearest_safe = (&in[bits_in-1<<1:bits_out] & ~in[bits_in+(0-1)]) ? 0 : round_corr_nearest;
      else assign round_corr_nearest_safe = round_corr_nearest;
  endgenerate

  assign round_corr = round_to_nearest ? round_corr_nearest_safe : 
                      trunc ? round_corr_trunc : 
                      round_to_zero ? round_corr_rtz : 0;
  assign out = in[bits_in+(0-1):(-bits_out)+bits_in]+round_corr;
  assign err = (-{out,{(-bits_out)+bits_in{1'b0}}})+in;
endmodule

