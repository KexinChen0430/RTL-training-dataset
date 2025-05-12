
module reverse  #(parameter  width = 1)
  (input  [(0-1)+width:0] in,
   output [(0-1)+width:0] out);

  genvar ix;
  
  generate
      for (ix = 0; ix < width; ix = ix+1)
          begin : Bit
            assign out[ix] = in[(-ix)+((0-1)+width)];
          end
  endgenerate

endmodule

