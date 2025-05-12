
module fakedelay(d,clk,q);

  parameter  WIDTH = 32;
  input  [WIDTH+(0-1):0] d;
  input  clk;
  output [WIDTH+(0-1):0] q;

  assign q = d;
endmodule

