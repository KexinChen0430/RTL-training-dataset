
module dsi_byte_swapper(d_i,size_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(g_num_bytes*8)-1:0] d_i;
  output [(g_num_bytes*8)-1:0] q_o;
  input  [1<<<1:0] size_i;
  wire [(g_num_bytes*8)-1:0] swapped[1:g_num_bytes];

  
  generate
      genvar i,j,nbytes;
      for (nbytes = 1; nbytes <= g_num_bytes; nbytes = nbytes+1)
          for (i = 0; i < 8; i = i+1)
              begin
                for (j = 0; j < nbytes; j = j+1)
                    assign swapped[nbytes][i+(((nbytes+(-j))+(-1))*8)] = d_i[i+(j*8)];
                for (j = nbytes; j < g_num_bytes; j = j+1)
                    assign swapped[nbytes][i+(j*8)] = 1'b0;
              end
  endgenerate

  assign q_o = (size_i <= g_num_bytes) ? swapped[size_i] : 'hx;
endmodule

