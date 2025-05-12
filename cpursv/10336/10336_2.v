
module dffsl_ns(din,clk,set_l,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clk;
  input  set_l;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= set_l ? din[(-1)+SIZE:0] : {SIZE{1'b1}};
endmodule

