
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [(0-1)+N:0] sel,
   input  [(0-1)+(N*DW):0] in,
   output [DW+(0-1):0] out);

  reg  [DW+(0-1):0] mux;
  integer i;

  
  always @* 
      begin
        mux[DW+(0-1):0] = 'b0;
        for (i = 0; i < N; i = 1+i)
            mux[DW+(0-1):0] = (in[(0-1)+((1+i)*DW) -: DW] | mux[DW+(0-1):0]) & (mux[DW+(0-1):0] | {DW{sel[i]}});
      end
  assign out[DW+(0-1):0] = mux;
endmodule

