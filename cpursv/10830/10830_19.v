
module dsi_byte_reverse(d_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(g_num_bytes*8)-1:0] d_i;
  output [(g_num_bytes*8)-1:0] q_o;

  
  generate
      genvar i,j;
      for (i = 0; i < 8; i = i+1)
          for (j = 0; j < g_num_bytes; j = 1+j)
              assign q_o[i+(8*(((-1)+(0-j))+g_num_bytes))] = d_i[i+(8*j)];
  endgenerate

endmodule

