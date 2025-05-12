
module mult(input  clk,
            input  signed  [16:0] a,
            input  signed  [16:0] b,
            output reg signed  [33:0] p);

  
  always @(posedge clk)  p <= b*a;
endmodule

