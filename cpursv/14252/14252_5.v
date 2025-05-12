
module compressBy2  #(parameter  inWidth = 1)
  (input  [(-1)+inWidth:0] in,
   output [((-1)+inWidth)/1<<1:0] out);

  localparam  maxBitNumReduced = ((-1)+inWidth)/1<<1;

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[1+ix<<1:ix<<1];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[(-1)+inWidth:maxBitNumReduced<<<1];
endmodule

