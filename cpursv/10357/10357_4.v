
module dffr_async_ns_cl_r1(din,clkl,rst,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clkl;
  input  rst;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(negedge clkl or posedge rst)
      q[SIZE+(0-1):0] <= rst ? {SIZE{1'b1}} : din[SIZE+(0-1):0];
endmodule

