
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = (Internal & ~clk) | (((~clk & ((clk & Internal) & (~clk | clk))) | ~((clk & Internal) & (~clk | clk))) & ((~clk & ((clk & Internal) & (~clk | clk))) | clk));
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

