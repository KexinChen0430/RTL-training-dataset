
module gen_test6(output [3:0] o);

  
  generate
      genvar i;
      for (i = 3; i >= 0; i = (0-1)+i)
          begin
            assign o[i] = 1'b0;
          end
  endgenerate

endmodule

