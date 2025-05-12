
module reverse  #(parameter  width = 1)
  (input  [width+(0-1):0] in,
   output [width+(0-1):0] out);

  genvar ix;
  
  generate
      for (ix = 0; ix < width; ix = ix+1)
          begin : Bit
            assign out[ix] = in[(width+(0-1))+(-ix)];
          end
  endgenerate

endmodule

