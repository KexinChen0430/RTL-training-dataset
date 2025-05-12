
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = clk ^ ((Internal | clk) & (((Internal | clk) | ~clk) & (Internal & ((Internal | clk) | ~clk))));
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

