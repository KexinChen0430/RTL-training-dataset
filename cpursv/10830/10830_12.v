
module dsi_byte_reverse(d_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(8*g_num_bytes)-1:0] d_i;
  output [(8*g_num_bytes)-1:0] q_o;

  
  generate
      genvar i,j;
      for (i = 0; i < 8; i = 1+i)
          for (j = 0; j < g_num_bytes; j = 1+j)
              assign q_o[i+(8*((g_num_bytes+(-1))+(0-j)))] = d_i[i+(8*j)];
  endgenerate

endmodule

