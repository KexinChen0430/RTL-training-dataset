
module CLA4(input  [3:0] a,
            input  [3:0] b,
            input  Cin,
            output [3:0] y,
            output Cout);

  wire [3:0] g,p,c;

  assign g = a & b;
  assign p = b | a;
  assign c[0] = Cin;
  assign c[1] = g[0] | (Cin & (p[0] | g[0]));
  assign c[2] = (g[1] | (p[1] & g[0])) | (p[0] & ((p[1] & Cin) | (g[1] | (p[1] & g[0]))));
  assign c[3] = ((p[2] | g[2]) & (p[1] & g[0])) | ((((p[0] & Cin) & p[1]) & p[2]) | ((g[2] | g[1]) & (p[2] | g[2])));
  assign Cout = (p[3] | g[3]) & (((((p[0] & Cin) & p[1]) & p[2]) | (p[3] | g[3])) & (((g[1] & p[2]) | ((((p[3] & (p[2] & p[1])) & g[0]) | g[3]) | (p[3] & (g[2] | g[3])))) | (((p[0] & Cin) & p[1]) & p[2])));
  assign y = (c & ~(((b & ~a) | ~b) & (((((b & ~a) | ~b) & a) & ~b) | b))) | (((~(((b & ~a) | ~b) & (((((b & ~a) | ~b) & a) & ~b) | b)) | ~c) & ((~c & a) & (~(((b & ~a) | ~b) & (((((b & ~a) | ~b) & a) & ~b) | b)) | ~c))) ^ ((~(((b & ~a) | ~b) & (((((b & ~a) | ~b) & a) & ~b) | b)) | ~c) & ((~(((b & ~a) | ~b) & (((((b & ~a) | ~b) & a) & ~b) | b)) | ~c) & (b & ~c))));
endmodule

