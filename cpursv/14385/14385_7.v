
module Voter  #(parameter  WIDTH = 1)
  (input  [WIDTH-1:0] A,B,C,
   output [WIDTH-1:0] True);

  genvar i;
  
  generate
      for (i = 0; i < WIDTH; i = i+1)
          begin : Vote_Bit
            assign True[i] = (C[i] && (B[i] || ((C[i] || B[i]) && A[i]))) || 
                   (B[i] && ((C[i] || B[i]) && A[i]));
          end
  endgenerate

endmodule

