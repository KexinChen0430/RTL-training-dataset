
module Dflop(D,Clk,Q);

  input  D,Clk;
  output reg Q;

  
  always @(D or Clk)  if (Clk) Q = D;
    
endmodule

