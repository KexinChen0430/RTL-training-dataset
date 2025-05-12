
module dffr_async_ns_cl_r1(din,clkl,rst,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clkl;
  input  rst;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(negedge clkl or posedge rst)
      q[(-1)+SIZE:0] <= rst ? {SIZE{1'b1}} : din[(-1)+SIZE:0];
endmodule

