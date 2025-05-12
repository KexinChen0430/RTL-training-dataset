
module finite_parallel_adder  #(parameter  M = 4, N_INPUT = 1<<1)
  (input  [(0-1)+(M*N_INPUT):0] in,
   output [M-1:0] out);

  genvar i,j;
  for (i = 0; i < M; i = 1+i)
      begin : add
        wire [(0-1)+N_INPUT:0] z;

        for (j = 0; j < N_INPUT; j = 1+j)
            begin : arrange
              assign z[j] = in[i+(j*M)];
            end
        assign out[i] = ^z;
      end
endmodule

