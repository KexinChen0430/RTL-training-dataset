
module Voter  #(parameter  WIDTH = 1)
  (input  [WIDTH+(0-1):0] A,B,C,
   output [WIDTH+(0-1):0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = i+1)
          begin : Vote_Bit
            assign True[i] = (C[i] && A[i]) || ((C[i] && B[i]) || (A[i] && B[i]));
          end
  endgenerate

endmodule

