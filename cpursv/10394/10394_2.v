
module finite_parallel_adder  #(parameter  M = 4, N_INPUT = 2)
  (input  [(M*N_INPUT)-1:0] in,
   output [(-1)+M:0] out);

  genvar i,j;
  for (i = 0; i < M; i = i+1)
      begin : add
        wire [(-1)+N_INPUT:0] z;

        for (j = 0; j < N_INPUT; j = j+1)
            begin : arrange
              assign z[j] = in[(j*M)+i];
            end
        assign out[i] = ^z;
      end
endmodule

