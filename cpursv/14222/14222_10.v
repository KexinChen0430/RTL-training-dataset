
module compressBy4  #(parameter  inWidth = 1)
  (input  [inWidth+(0-1):0] in,
   output [(inWidth+(0-1))/4:0] out);

  localparam  maxBitNumReduced = (inWidth+(0-1))/4;

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[(4*ix)+3:4*ix];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[inWidth+(0-1):maxBitNumReduced*4];
endmodule

