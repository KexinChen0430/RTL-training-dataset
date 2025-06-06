
module compressBy2  #(parameter  inWidth = 1)
  (input  [inWidth-1:0] in,
   output [(inWidth-1)/2:0] out);

  localparam  maxBitNumReduced = (inWidth-1)/2;

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[1+ix<<1:ix<<1];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[inWidth-1:2*maxBitNumReduced];
endmodule

