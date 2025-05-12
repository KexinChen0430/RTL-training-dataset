
module dff_s(din,clk,q,se,si,so);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clk;
  output [(-1)+SIZE:0] q;
  input  se;
  input  [(-1)+SIZE:0] si;
  output [(-1)+SIZE:0] so;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= se ? si[(-1)+SIZE:0] : din[(-1)+SIZE:0];
  assign so[(-1)+SIZE:0] = q[(-1)+SIZE:0];
endmodule

