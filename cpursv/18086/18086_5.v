
module mul_plain(a,b,p);

  parameter  M = 6;
  parameter  N = 6;
  input  wire [(0-1)+M:0] a;
  input  wire [N-1:0] b;
  output wire [((0-1)+M)+N:0] p;

  assign p = b*a;
endmodule

