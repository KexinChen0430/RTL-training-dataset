
module CLA4(input  [3:0] a,
            input  [3:0] b,
            input  Cin,
            output [3:0] y,
            output Cout);

  wire [3:0] g,p,c;

  assign g = a & b;
  assign p = a | b;
  assign c[0] = Cin;
  assign c[1] = (p[0] | g[0]) & (g[0] | Cin);
  assign c[2] = ((g[1] | p[1]) & (g[0] | g[1])) | (p[0] & (p[1] & Cin));
  assign c[3] = (((((p[1] & Cin) & p[2]) & p[0]) | ((((g[1] & (g[2] | p[2])) | g[2]) | p[1]) & ((g[0] | ((g[1] & (g[2] | p[2])) | g[2])) | (((p[1] & Cin) & p[2]) & p[0])))) & p[2]) | ((g[1] & (g[2] | p[2])) | g[2]);
  assign Cout = (((((p[3] & p[2]) | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & ((g[0] | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & (((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3]) | p[1]))) | (p[1] & Cin)) & ((p[3] & p[2]) | (((p[3] & p[2]) | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & ((g[0] | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & (((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3]) | p[1]))))) & (p[0] | (((p[3] & p[2]) | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & ((g[0] | ((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3])) & (((((g[2] & p[3]) | (p[2] & g[1])) & (g[3] | p[3])) | g[3]) | p[1]))));
  assign y = (c & ~((a & ~b) | (~a & b))) | (((((((c & ~((a & ~b) | (~a & b))) | ~c) & ((((c & ~((a & ~b) | (~a & b))) | ~c) & (((c & ~((a & ~b) | (~a & b))) | ~c) & (((a & ~c) & ((c & ~((a & ~b) | (~a & b))) | ~c)) & ((c & ~((a & ~b) | (~a & b))) | ~c)))) & ((c & ~((a & ~b) | (~a & b))) | ~c))) & ((c & ~((a & ~b) | (~a & b))) | ~c)) & ((c & ~((a & ~b) | (~a & b))) | ~c)) & ((c & ~((a & ~b) | (~a & b))) | ~c)) ^ (((c & ~((a & ~b) | (~a & b))) | ~c) & ((((c & ~((a & ~b) | (~a & b))) | ~c) & (((c & ~((a & ~b) | (~a & b))) | ~c) & (((c & ~((a & ~b) | (~a & b))) | ~c) & (((c & ~((a & ~b) | (~a & b))) | ~c) & ((((c & ~((a & ~b) | (~a & b))) | ~c) & ((b & ~c) & ((c & ~((a & ~b) | (~a & b))) | ~c))) & ((c & ~((a & ~b) | (~a & b))) | ~c)))))) & ((c & ~((a & ~b) | (~a & b))) | ~c))));
endmodule

