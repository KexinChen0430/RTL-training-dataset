
module clkDiv(input  clk,
              output divClk);

  parameter  n = 25;
  reg  [(0-1)+n:0]  count = 0;

  assign divClk = count[(0-1)+n];
  
  always @(posedge clk)  count <= 1+count;
endmodule

