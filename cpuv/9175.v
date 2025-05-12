module Mem(a, d, dpra, clk, we, spo, dpo)
;
  input [8:0]a; 
  input [4:0]d; 
  input [8:0]dpra; 
  input clk; 
  input we; 
  output [4:0]spo; 
  output [4:0]dpo; 
endmodule