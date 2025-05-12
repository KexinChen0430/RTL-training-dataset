
module Test(clk,Value,Result);

  input  clk;
  input  Value;
  output Result;
  reg  Internal;

  assign Result = clk ^ (((~Internal | ((Internal & clk) ^ Internal)) | clk) & Internal);
  
  always @(posedge clk)  Internal <= #1 Value;
endmodule

