
module dsi_byte_swapper(d_i,size_i,q_o);

  parameter  g_num_bytes = 4;
  input  [(-1)+(8*g_num_bytes):0] d_i;
  output [(-1)+(8*g_num_bytes):0] q_o;
  input  [2:0] size_i;
  wire [(-1)+(8*g_num_bytes):0] swapped[1:g_num_bytes];

  
  generate
      genvar i,j,nbytes;
      for (nbytes = 1; nbytes <= g_num_bytes; nbytes = 1+nbytes)
          for (i = 0; i < 8; i = 1+i)
              begin
                for (j = 0; j < nbytes; j = 1+j)
                    assign swapped[nbytes][i+(((0-j)+(nbytes+(-1)))*8)] = d_i[i+(8*j)];
                for (j = nbytes; j < g_num_bytes; j = 1+j)
                    assign swapped[nbytes][i+(8*j)] = 1'b0;
              end
  endgenerate

  assign q_o = (size_i <= g_num_bytes) ? swapped[size_i] : 'hx;
endmodule

