
module compressBy4  #(parameter  inWidth = 1)
  (input  [(-1)+inWidth:0] in,
   output [((-1)+inWidth)/4:0] out);

  localparam  maxBitNumReduced = ((-1)+inWidth)/4;

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[(4*ix)+3:4*ix];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[(-1)+inWidth:4*maxBitNumReduced];
endmodule

