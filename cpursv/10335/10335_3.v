
module dffsl_async_ns(din,clk,set_l,q);

  parameter  SIZE = 1;
  input  [SIZE+(-1):0] din;
  input  clk;
  input  set_l;
  output [SIZE+(-1):0] q;
  reg  [SIZE+(-1):0] q;

  
  always @(posedge clk or negedge set_l)
      q[SIZE+(-1):0] <= ~set_l ? {SIZE{1'b1}} : ({SIZE{~set_l}} | din[SIZE+(-1):0]);
endmodule

