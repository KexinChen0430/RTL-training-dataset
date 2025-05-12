
module dffsl_async_ns(din,clk,set_l,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  input  set_l;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk or negedge set_l)
      q[SIZE+(0-1):0] <= ~set_l ? {SIZE{1'b1}} : (din[SIZE+(0-1):0] | {SIZE{~set_l}});
endmodule

