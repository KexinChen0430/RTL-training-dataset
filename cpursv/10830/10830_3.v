
module dsi_byte_reverse(d_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(-1)+(g_num_bytes*8):0] d_i;
  output [(-1)+(g_num_bytes*8):0] q_o;

  
  generate
      genvar i,j;
      for (i = 0; i < 8; i = i+1)
          for (j = 0; j < g_num_bytes; j = 1+j)
              assign q_o[i+(8*((-1)+(g_num_bytes+(0-j))))] = d_i[(j*8)+i];
  endgenerate

endmodule

