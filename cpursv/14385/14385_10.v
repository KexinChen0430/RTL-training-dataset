
module Voter  #(parameter  WIDTH = 1)
  (input  [(-1)+WIDTH:0] A,B,C,
   output [(-1)+WIDTH:0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = 1+i)
          begin : Vote_Bit
            assign True[i] = (A[i] && (C[i] || B[i]) && C[i]) || 
                   ((B[i] && C[i]) || (B[i] && (A[i] && (C[i] || B[i]))));
          end
  endgenerate

endmodule

