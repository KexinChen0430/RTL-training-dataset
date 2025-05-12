
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = clk ^ ((~clk | (((clk & Internal) ^ Internal) | clk)) & ((~clk | (((clk & Internal) ^ Internal) | clk)) & ((~clk | (((clk & Internal) ^ Internal) | clk)) & Internal)));
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

