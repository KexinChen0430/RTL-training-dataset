
module XNOR  #(parameter  SIZE = 8)
  (input  wire [SIZE-1:0] inA,
   input  wire [SIZE-1:0] inB,
   output reg [SIZE-1:0] out);

  
  always @(*)
      begin
        out <= ~(((((inB | inA) & (~inA & (~inB | inB))) | ((inB | inA) | ~inA)) & ((((~inA & (~inB | inB)) | ~inB) & inA) & (((inB | inA) & (~inA & (~inB | inB))) | ((inB | inA) | ~inA)))) ^ (((((inB | inA) & (~inA & (~inB | inB))) | ((inB | inA) | ~inA)) & ((inB & inA) ^ inB)) & (((inB | inA) & (~inA & (~inB | inB))) | ((inB | inA) | ~inA))));
      end
endmodule

