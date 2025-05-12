
module XNOR  #(parameter  SIZE = 8)
  (input  wire [SIZE-1:0] inA,
   input  wire [SIZE-1:0] inB,
   output reg [SIZE-1:0] out);

  
  always @(*)
      begin
        out <= ~(((inB | ~inB) & inA) ^ ((inA | ((~inA | inA) & inB)) & (((~inA | inA) & inB) & (inB | ~inB))));
      end
endmodule

