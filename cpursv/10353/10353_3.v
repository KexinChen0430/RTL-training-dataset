
module dffre_ns(din,rst,en,clk,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  en;
  input  rst;
  input  clk;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= rst ? {SIZE{1'b0}} : 
                        en ? din[SIZE+(0-1):0] : q[SIZE+(0-1):0];
endmodule

