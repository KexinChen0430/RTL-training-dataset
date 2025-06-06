
module dffr_async(din,clk,rst,q,se,si,so);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  input  rst;
  output [SIZE+(0-1):0] q;
  input  se;
  input  [SIZE+(0-1):0] si;
  output [SIZE+(0-1):0] so;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk or posedge rst)
      q[SIZE+(0-1):0] <= rst ? {SIZE{1'b0}} : 
                        se ? si[SIZE+(0-1):0] : din[SIZE+(0-1):0];
  assign so[SIZE+(0-1):0] = q[SIZE+(0-1):0];
endmodule

