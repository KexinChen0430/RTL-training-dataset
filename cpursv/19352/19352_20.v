
module XNOR  #(parameter  SIZE = 8)
  (input  wire [SIZE+(0-1):0] inA,
   input  wire [SIZE+(0-1):0] inB,
   output reg [SIZE+(0-1):0] out);

  
  always @(*)
      begin
        out <= ~((((inB & inA) & ~inA) ^ (~inA & (inB & ((~inA | inA) & inB)))) | ((inA | inB) & ~inB));
      end
endmodule

