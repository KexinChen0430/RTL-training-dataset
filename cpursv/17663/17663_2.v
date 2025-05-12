
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = ((((clk & Internal) & ~Internal) | Internal) & (((clk & Internal) & ~Internal) | ~(clk & Internal))) ^ ((clk & Internal) ^ clk);
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

