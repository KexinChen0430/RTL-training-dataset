
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = (((~clk | (Internal | clk)) & ((~clk | (Internal | clk)) & Internal)) & ((Internal | clk) | ~Internal)) ^ clk;
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

