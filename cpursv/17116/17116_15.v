
module carry_look_ahead_adder(input  [3:0] a,
                              input  [3:0] b,
                              input  cin,
                              output cout,
                              output [3:0] s,
                              output p,
                              output g,
                              output c);

  wire [3:0] p;
  wire [3:0] g;
  wire [3:0] c;

  assign p = (b & ((b & ~a) | ~b)) | ((((b & ~a) | ~b) & a) & ~b);
  assign g = b & a;
  assign c[0] = (cin | g[0]) & (g[0] | p[0]);
  assign c[1] = (g[1] | (g[0] & p[1])) | (p[0] & (cin & p[1]));
  assign c[2] = (((g[0] | ((g[1] & (((g[0] | p[0]) & ((cin | g[0]) & p[1])) | p[2])) & p[2])) | (p[0] & (cin & p[1]))) | g[2]) & (g[2] | ((((((g[1] & (((g[0] | p[0]) & ((cin | g[0]) & p[1])) | p[2])) & p[2]) | (p[0] & p[1])) | p[1]) & (p[2] | ((cin | g[0]) & (g[0] | p[0])))) & p[2]));
  assign c[3] = (g[2] & ((((g[1] | g[1]) | p[1]) | g[2]) & p[3])) | (((p[2] | (((((p[3] & ((((g[0] | p[0]) & (p[2] & p[1])) | (p[2] & p[1])) | p[2])) & (p[2] | (cin | g[0]))) & p[1]) | g[3]) & (g[3] | ((cin | g[0]) & (g[0] | p[0]))))) & (g[3] | (p[3] & ((g[1] | g[1]) | p[1])))) & ((g[1] | g[3]) | ((cin | g[0]) & ((g[1] | g[0]) | p[0]))));
  assign cout = c[3];
  assign s[0] = b[0]+(a[0]+cin);
  assign s[1] = b[1]+(a[1]+c[0]);
  assign s[2] = a[2]+(c[1]+b[2]);
  assign s[3] = b[3]+(c[2]+a[3]);
endmodule

