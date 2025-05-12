
module reverse  #(parameter  width = 1)
  (input  [(-1)+width:0] in,
   output [(-1)+width:0] out);

  genvar ix;
  
  generate
      for (ix = 0; ix < width; ix = 1+ix)
          begin : Bit
            assign out[ix] = in[(-1)+(width+(0-ix))];
          end
  endgenerate

endmodule

