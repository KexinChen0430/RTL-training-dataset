
module compressBy4  #(parameter  inWidth = 1)
  (input  [(-1)+inWidth:0] in,
   output [((-1)+inWidth)*(1/4):0] out);

  localparam  maxBitNumReduced = ((-1)+inWidth)*(1/4);

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = 1+ix)
          begin : Bit
            assign out[ix] = |in[3+(ix*4):ix*4];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[(-1)+inWidth:4*maxBitNumReduced];
endmodule

