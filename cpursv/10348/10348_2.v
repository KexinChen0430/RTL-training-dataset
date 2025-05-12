
module dffrle_ns(din,rst_l,en,clk,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  en;
  input  rst_l;
  input  clk;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= rst_l ? (en ? din[SIZE+(0-1):0] : q[SIZE+(0-1):0]) : {SIZE{1'b0}};
endmodule

