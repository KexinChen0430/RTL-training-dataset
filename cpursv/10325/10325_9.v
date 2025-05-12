
module dffrl_async_ns(din,clk,rst_l,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  input  rst_l;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk or negedge rst_l)
      q[SIZE+(0-1):0] <= ~rst_l ? {SIZE{1'b0}} : (din[SIZE+(0-1):0] & {SIZE{rst_l}});
endmodule

