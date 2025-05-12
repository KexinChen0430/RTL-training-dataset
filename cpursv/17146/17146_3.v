
module clkDiv(input  clk,
              output divClk);

  parameter  n = 25;
  reg  [n-1:0]  count = 0;

  assign divClk = count[n-1];
  
  always @(posedge clk)  count <= 1+count;
endmodule

