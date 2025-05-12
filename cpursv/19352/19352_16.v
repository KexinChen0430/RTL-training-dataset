
module XNOR  #(parameter  SIZE = 8)
  (input  wire [(-1)+SIZE:0] inA,
   input  wire [(-1)+SIZE:0] inB,
   output reg [(-1)+SIZE:0] out);

  
  always @(*)
      begin
        out <= ~(inA ^ ((inA | ~inA) & ((inA | ~inA) & inB)));
      end
endmodule

