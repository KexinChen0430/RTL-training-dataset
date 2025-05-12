
module dff_ns(din,clk,q);

  parameter  SIZE = 1;
  input  [SIZE+(0-1):0] din;
  input  clk;
  output [SIZE+(0-1):0] q;
  reg  [SIZE+(0-1):0] q;

  
  always @(posedge clk)
      q[SIZE+(0-1):0] <= din[SIZE+(0-1):0];
endmodule

