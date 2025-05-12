
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N-1:0] sel,
   input  [(N*DW)-1:0] in,
   output [DW-1:0] out);

  reg  [DW-1:0] mux;
  integer i;

  
  always @* 
      begin
        mux[DW-1:0] = 'b0;
        for (i = 0; i < N; i = i+1)
            mux[DW-1:0] = mux[DW-1:0] | ((mux[DW-1:0] | in[((i+1)*DW)+(-1) -: DW]) & {DW{sel[i]}});
      end
  assign out[DW-1:0] = mux;
endmodule

