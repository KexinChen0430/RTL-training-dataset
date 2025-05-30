
module g_p(g,p,c_in,g_out,p_out,c_out);

  input  [1:0] g,p;
  input  c_in;
  output g_out,p_out,c_out;

  assign g_out = ((p[1] & g[0]) | (g[0] & (p[0] & (p[1] | ((((p[1] & g[0]) & (p[0] & (g[0] | c_in))) | (g[0] & (g[1] & c_in))) | (g[1] & g[0])))))) | g[1];
  assign p_out = (((g[0] | c_in) | ((c_in & g[0]) | p[0])) & p[1]) & p[0];
  assign c_out = g[0] | ((p[0] & ((p[0] & (g[0] | c_in)) | (c_in & (g[0] | p[0])))) & c_in);
endmodule

