
module XNOR  #(parameter  SIZE = 8)
  (input  wire [(0-1)+SIZE:0] inA,
   input  wire [(0-1)+SIZE:0] inB,
   output reg [(0-1)+SIZE:0] out);

  
  always @(*)
      begin
        out <= ~((~((inA & ((~inA | inA) | ((inB & ~inA) | (((inB | ~inB) & inA) & ~inA)))) & (inB | ~inB)) & ((((~inA | inA) | ((inB & ~inA) | (((inB | ~inB) & inA) & ~inA))) & (inB & (~inA | inA))) & (inB | ~inB))) | (((inA & ((~inA | inA) | ((inB & ~inA) | (((inB | ~inB) & inA) & ~inA)))) & (inB | ~inB)) & ~((((~inA | inA) | ((inB & ~inA) | (((inB | ~inB) & inA) & ~inA))) & (inB & (~inA | inA))) & (inB | ~inB))));
      end
endmodule

