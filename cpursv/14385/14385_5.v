
module Voter  #(parameter  WIDTH = 1)
  (input  [WIDTH-1:0] A,B,C,
   output [WIDTH-1:0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = 1+i)
          begin : Vote_Bit
            assign True[i] = ((B[i] && C[i]) || A[i]) && ((A[i] && C[i]) || B[i]);
          end
  endgenerate

endmodule

