
module dffr_ns(din,clk,rst,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  input  rst;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= rst ? {SIZE{1'b0}} : din[SIZE+(0-1):0];
endmodule

