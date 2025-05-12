
module dffr_async(din,clk,rst,q,se,si,so);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clk;
  input  rst;
  output [(-1)+SIZE:0] q;
  input  se;
  input  [(-1)+SIZE:0] si;
  output [(-1)+SIZE:0] so;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk or posedge rst)
      q[(-1)+SIZE:0] <= rst ? {SIZE{1'b0}} : 
                       se ? si[(-1)+SIZE:0] : din[(-1)+SIZE:0];
  assign so[(-1)+SIZE:0] = q[(-1)+SIZE:0];
endmodule

