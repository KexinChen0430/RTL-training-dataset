
module mul_plain(a,b,p);

  parameter  M = 6;
  parameter  N = 6;
  input  wire [M+(0-1):0] a;
  input  wire [(0-1)+N:0] b;
  output wire [M+((0-1)+N):0] p;

  assign p = b*a;
endmodule

