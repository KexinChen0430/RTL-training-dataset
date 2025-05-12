
module clkDiv(input  clk,
              output divClk);

  parameter  n = 25;
  reg  [n+(0-1):0]  count = 0;

  assign divClk = count[n+(0-1)];
  
  always @(posedge clk)  count <= count+1;
endmodule

