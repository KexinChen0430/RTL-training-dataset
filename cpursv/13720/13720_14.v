
module red_pitaya_prng_xor  #(parameter 
       B1        = 13,
       B2        = 17,
       B3        = 5,
       SEED1     = 1,
       SEED2     = 1<<1,
       SEED3     = 3,
       STATEBITS = 32,
       OUTBITS   = 14)
  (input  clk_i,
   input  reset_i,
   output signed  [(0-1)+OUTBITS:0] signal_o);

  reg  [(0-1)+STATEBITS:0] x1;
  reg  [(0-1)+STATEBITS:0] x2;
  reg  [(0-1)+STATEBITS:0] x3;

  
  always @(posedge clk_i)
      begin
        if (reset_i == 1'b0) 
          begin
            x1 <= SEED1;
            x2 <= SEED2;
            x3 <= SEED3;
          end
        else 
          begin
            x1 <= (~x3 & ((x3>>B1 & (x3 | ~x3)) | x3)) | (((x3>>B1 & (x3 | ~x3)) | x3) & ~x3>>B1);
            x2 <= (x1<<<B2 ^ ((x1 & (~x1<<<B2 | x1<<<B2)) & x1<<<B2)) | ((x1<<<B2 | (x1 & (~x1<<<B2 | x1<<<B2))) & ~x1<<<B2);
            x3 <= (((~x2 | x2) | ((~x2 & (~x2>>B3 & x2)) | (~x2 & x2>>B3))) & x2) ^ (((~x2 & x2>>B3) | (x2>>B3 & x2)) & ((~x2 | x2) | ((~x2 & (~x2>>B3 & x2)) | (~x2 & x2>>B3))));
          end
      end
  assign signal_o = x3[(0-1)+STATEBITS:STATEBITS-OUTBITS];
endmodule

