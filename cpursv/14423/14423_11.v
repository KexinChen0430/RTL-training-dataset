
module CLA4(input  [3:0] a,
            input  [3:0] b,
            input  Cin,
            output [3:0] y,
            output Cout);

  wire [3:0] g,p,c;

  assign g = a & b;
  assign p = a | b;
  assign c[0] = Cin;
  assign c[1] = (g[0] | p[0]) & (g[0] | Cin);
  assign c[2] = (p[1] | g[1]) & (((p[1] | g[1]) & (g[0] | g[1])) | ((((p[1] | g[1]) & (g[0] | g[1])) | Cin) & p[0]));
  assign c[3] = (((((p[2] | g[2]) & (g[1] | g[2])) | p[1]) & ((p[2] & ((p[1] & Cin) & p[0])) | (((p[2] | g[2]) & (g[1] | g[2])) | g[0]))) | (p[2] & ((p[1] & Cin) & p[0]))) & (p[2] | g[2]);
  assign Cout = (p[2] & ((p[1] & g[0]) & p[3])) | ((((g[2] | g[3]) | ((g[1] & p[2]) & p[3])) | ((p[0] & (Cin & p[2])) & (p[3] & p[1]))) & (p[3] | g[3]));
  assign y = (~(b ^ a) | ~c) & ((((~(b ^ a) | ~c) & (a & ~c)) ^ ((~c & b) & (~(b ^ a) | ~c))) | c);
endmodule

