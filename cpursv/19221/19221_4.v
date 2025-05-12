
module Multiplier(clk,left,right,exp);

  input  clk;
  input  [5:0] left,right;
  output [2:0] exp;
  reg  [2:0] exp;
  wire signed  [2:0]  expl = left[5:3]+(-3);
  wire signed  [2:0]  expr = right[5:3]+(-3);
  reg  signed  [3:0] sumExp;

  
  always @(posedge clk)
      begin
        sumExp <= ((expr+expl) < -2) ? -3 : (expr+expl);
        exp[2:0] <= 3+sumExp;
      end
endmodule

