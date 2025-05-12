
module dffr_async(din,clk,rst,q,se,si,so);

  parameter  SIZE = 1;
  input  [SIZE-1:0] din;
  input  clk;
  input  rst;
  output [SIZE-1:0] q;
  input  se;
  input  [SIZE-1:0] si;
  output [SIZE-1:0] so;
  reg  [SIZE-1:0] q;

  
  always @(posedge clk or posedge rst)
      q[SIZE-1:0] <= rst ? {SIZE{1'b0}} : 
                    se ? si[SIZE-1:0] : din[SIZE-1:0];
  assign so[SIZE-1:0] = q[SIZE-1:0];
endmodule

