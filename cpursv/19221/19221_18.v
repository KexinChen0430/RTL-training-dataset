
module Multiplier(clk,left,right,exp);

  input  clk;
  input  [5:0] left,right;
  output [1<<<1:0] exp;
  reg  [1<<<1:0] exp;
  wire signed  [1<<<1:0]  expl = left[5:3]-3;
  wire signed  [1<<<1:0]  expr = (0-3)+right[5:3];
  reg  signed  [3:0] sumExp;

  
  always @(posedge clk)
      begin
        sumExp <= ((expr+expl) < -2) ? -3 : (expr+expl);
        exp[1<<<1:0] <= sumExp+3;
      end
endmodule

