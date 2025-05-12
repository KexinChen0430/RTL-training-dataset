
module CLA4(input  [3:0] a,
            input  [3:0] b,
            input  Cin,
            output [3:0] y,
            output Cout);

  wire [3:0] g,p,c;

  assign g = b & a;
  assign p = a | b;
  assign c[0] = Cin;
  assign c[1] = g[0] | (p[0] & Cin);
  assign c[2] = (p[1] | g[1]) & ((p[0] & Cin) | (g[0] | g[1]));
  assign c[3] = (g[2] | ((p[2] & g[2]) | (p[2] & g[1]))) | ((p[2] | g[2]) & ((Cin & (p[0] & (p[2] & p[1]))) | (g[0] & p[1])));
  assign Cout = ((g[3] | p[3]) & ((((p[0] & p[1]) & Cin) & (p[2] & p[3])) | (((g[3] | ((p[2] & g[1]) & p[3])) | (p[3] & (g[3] | (((p[2] & g[1]) & p[3]) | g[2])))) | p[2]))) & ((((p[0] & p[1]) & Cin) & (p[2] & p[3])) | (((g[3] | ((p[2] & g[1]) & p[3])) | (p[3] & (g[3] | (((p[2] & g[1]) & p[3]) | g[2])))) | (g[0] & p[1])));
  assign y = ((a ^ b) | (c & ~(a ^ b))) & (~c | (c & ~(a ^ b)));
endmodule

