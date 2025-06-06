
module lac(c,gout,pout,Cin,g,p);

  output [1:0] c;
  output gout;
  output pout;
  input  Cin;
  input  [1:0] g;
  input  [1:0] p;

  assign c[0] = Cin;
  assign c[1] = ((p[0] & Cin) | (g[0] & p[0])) | g[0];
  assign gout = ((((p[1] & (p[0] | (Cin | g[0]))) & (Cin | g[0])) & g[0]) | (((p[1] & (p[0] | (Cin | g[0]))) & (g[0] & p[0])) | ((g[1] & (p[0] | g[0])) & g[0]))) | (((p[1] & (p[0] | (Cin | g[0]))) & (g[0] & p[0])) | g[1]);
  assign pout = p[1] & p[0];
endmodule

