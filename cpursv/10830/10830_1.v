
module dsi_byte_reverse(d_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(-1)+(8*g_num_bytes):0] d_i;
  output [(-1)+(8*g_num_bytes):0] q_o;

  
  generate
      genvar i,j;
      for (i = 0; i < 8; i = 1+i)
          for (j = 0; j < g_num_bytes; j = j+1)
              assign q_o[((g_num_bytes+((-1)+(-j)))*8)+i] = d_i[(8*j)+i];
  endgenerate

endmodule

