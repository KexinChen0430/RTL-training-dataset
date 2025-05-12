
module lookahead(c_in,c_out,c,p,g,P,G);

  input  [3:0] p,g;
  input  c_in;
  output [2:0] c;
  output c_out;
  output P,G;

  assign c[0] = (c_in & p[0]) | g[0];
  assign c[1] = (p[1] | g[1]) & ((g[0] | g[1]) | ((p[1] & c_in) & p[0]));
  assign c[2] = (p[2] & (((p[1] & g[0]) | g[2]) | ((g[2] | g[1]) & p[2]))) | ((((p[2] & p[1]) & p[0]) & c_in) | g[2]);
  assign c_out = ((((p[2] & p[1]) & p[3]) & g[0]) | (g[2] & p[3])) | ((g[3] | ((p[3] & g[1]) & p[2])) | ((p[2] & p[1]) & ((c_in & p[0]) & p[3])));
  assign G = (((((((p[2] & p[1]) & p[0]) & p[3]) | (((p[2] & p[1]) & p[3]) & g[0])) | ((p[3] & g[1]) & p[2])) | g[3]) | (g[2] & p[3])) & (((g[3] | ((p[3] & g[1]) & p[2])) | g[0]) | (g[2] & p[3]));
  assign P = ((p[2] & p[1]) & p[0]) & p[3];
endmodule

