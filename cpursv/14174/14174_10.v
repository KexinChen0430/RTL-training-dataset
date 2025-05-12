
module reverse  #(parameter  width = 1)
  (input  [width-1:0] in,
   output [width-1:0] out);

  genvar ix;
  
  generate
      for (ix = 0; ix < width; ix = 1+ix)
          begin : Bit
            assign out[ix] = in[((0-1)+(-ix))+width];
          end
  endgenerate

endmodule

