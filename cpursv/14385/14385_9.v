
module Voter  #(parameter  WIDTH = 1)
  (input  [(0-1)+WIDTH:0] A,B,C,
   output [(0-1)+WIDTH:0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = 1+i)
          begin : Vote_Bit
            assign True[i] = (B[i] || A[i]) && (C[i] || B[i]) && (A[i] || C[i]);
          end
  endgenerate

endmodule

