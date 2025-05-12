
module Voter  #(parameter  WIDTH = 1)
  (input  [WIDTH+(0-1):0] A,B,C,
   output [WIDTH+(0-1):0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = 1+i)
          begin : Vote_Bit
            assign True[i] = (C[i] && A[i]) || (B[i] && (A[i] || C[i]));
          end
  endgenerate

endmodule

