
module CLA4(input  [3:0] a,
            input  [3:0] b,
            input  Cin,
            output [3:0] y,
            output Cout);

  wire [3:0] g,p,c;

  assign g = b & a;
  assign p = b | a;
  assign c[0] = Cin;
  assign c[1] = g[0] | ((g[0] | Cin) & p[0]);
  assign c[2] = ((g[0] | g[1]) & p[1]) | (((p[0] & p[1]) & Cin) | g[1]);
  assign c[3] = g[2] | ((p[2] & (((((g[2] | ((g[1] & p[2]) | (g[2] & p[2]))) | p[1]) & ((g[0] & p[2]) | (g[2] | ((g[1] & p[2]) | (g[2] & p[2]))))) | p[1]) & (p[0] & Cin))) | ((((g[2] | ((g[1] & p[2]) | (g[2] & p[2]))) | p[1]) & ((g[0] & p[2]) | (g[2] | ((g[1] & p[2]) | (g[2] & p[2]))))) & p[2]));
  assign Cout = ((p[2] & p[1]) & (p[3] & g[0])) | (((p[2] & (((p[0] & p[1]) & Cin) & p[3])) | ((g[2] & p[3]) | g[3])) | ((((g[2] & p[3]) | (g[1] & p[2])) | g[3]) & p[3]));
  assign y = ((~a & b) | (((~a & b) | a) & ~b)) ^ c;
endmodule

