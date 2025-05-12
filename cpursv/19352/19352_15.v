
module XNOR  #(parameter  SIZE = 8)
  (input  wire [(0-1)+SIZE:0] inA,
   input  wire [(0-1)+SIZE:0] inB,
   output reg [(0-1)+SIZE:0] out);

  
  always @(*)
      begin
        out <= ~(inB ^ ((inB | ~inB) & inA));
      end
endmodule

