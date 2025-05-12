
module finite_parallel_adder  #(parameter  M = 4, N_INPUT = 2)
  (input  [(N_INPUT*M)+(-1):0] in,
   output [(-1)+M:0] out);

  genvar i,j;
  for (i = 0; i < M; i = 1+i)
      begin : add
        wire [N_INPUT+(-1):0] z;

        for (j = 0; j < N_INPUT; j = 1+j)
            begin : arrange
              assign z[j] = in[(M*j)+i];
            end
        assign out[i] = ^z;
      end
endmodule

