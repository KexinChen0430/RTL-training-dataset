
module XNOR  #(parameter  SIZE = 8)
  (input  wire [SIZE-1:0] inA,
   input  wire [SIZE-1:0] inB,
   output reg [SIZE-1:0] out);

  
  always @(*)
      begin
        out <= ~((((inB & ~inA) | inA) & ~inB) | (((((inA | ~inA) & inB) & inB) & ((inA | ~inA) & inB)) ^ (inB & inA)));
      end
endmodule

