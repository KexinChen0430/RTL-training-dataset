
module latch(input  d,
             output reg q,
             input  clk);

  
  always @(clk)  q <= d;
endmodule

