
module reverse  #(parameter  width = 1)
  (input  [width+(-1):0] in,
   output [width+(-1):0] out);

  genvar ix;
  
  generate
      for (ix = 0; ix < width; ix = ix+1)
          begin : Bit
            assign out[ix] = in[((-1)+(0-ix))+width];
          end
  endgenerate

endmodule

