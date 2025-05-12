
module flip_flop(input  d,
                 output reg q,
                 input  clk);

  
  always @(posedge clk)  q <= d;
endmodule

