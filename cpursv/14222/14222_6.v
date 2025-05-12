
module compressBy4  #(parameter  inWidth = 1)
  (input  [(0-1)+inWidth:0] in,
   output [((0-1)+inWidth)*(1/4):0] out);

  localparam  maxBitNumReduced = ((0-1)+inWidth)*(1/4);

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[3+(4*ix):4*ix];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[(0-1)+inWidth:maxBitNumReduced*4];
endmodule

