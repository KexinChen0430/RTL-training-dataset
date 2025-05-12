
module dff_sscan(din,clk,q,se,si,so);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  output [SIZE+(0-1):0] q;
  input  se;
  input  [SIZE+(0-1):0] si;
  output [SIZE+(0-1):0] so;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= din[SIZE+(0-1):0];
  assign so = {SIZE{1'b0}};
endmodule

