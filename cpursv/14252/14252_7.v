
module compressBy2  #(parameter  inWidth = 1)
  (input  [inWidth+(0-1):0] in,
   output [(inWidth+(0-1))/1<<1:0] out);

  localparam  maxBitNumReduced = (inWidth+(0-1))/1<<1;

  genvar ix;
  
  generate
      for (ix = 0; ix < maxBitNumReduced; ix = ix+1)
          begin : Bit
            assign out[ix] = |in[1+(1<<1*ix):1<<1*ix];
          end
  endgenerate

  assign out[maxBitNumReduced] = |in[inWidth+(0-1):maxBitNumReduced<<<1];
endmodule

