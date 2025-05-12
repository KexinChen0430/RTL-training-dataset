
module compressBy4  #(parameter  inWidth = 1)
  (input  [inWidth+(-1):0] in,
   output [(1/4)*(inWidth+(-1)):0] out);

  localparam  maxBitNumReduced = (1/4)*(inWidth+(-1));

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = 1+ix)
          begin : Bit
            assign out[ix] = |in[3+(ix*4):ix*4];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[inWidth+(-1):maxBitNumReduced*4];
endmodule

