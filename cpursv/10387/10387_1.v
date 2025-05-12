
module dffrle_s(din,rst_l,en,clk,q,se,si,so);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  en;
  input  rst_l;
  input  clk;
  output [(-1)+SIZE:0] q;
  input  se;
  input  [(-1)+SIZE:0] si;
  output [(-1)+SIZE:0] so;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= se ? si[(-1)+SIZE:0] : 
                       rst_l ? (en ? din[(-1)+SIZE:0] : q[(-1)+SIZE:0]) : {SIZE{1'b0}};
  assign so[(-1)+SIZE:0] = q[(-1)+SIZE:0];
endmodule

