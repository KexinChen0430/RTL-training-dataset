
module compressBy4  #(parameter  inWidth = 1)
  (input  [inWidth+(-1):0] in,
   output [(inWidth+(-1))*(1/4):0] out);

  localparam  maxBitNumReduced = (inWidth+(-1))*(1/4);

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = 1+ix)
          begin : Bit
            assign out[ix] = |in[(ix*4)+3:ix*4];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[inWidth+(-1):4*maxBitNumReduced];
endmodule

