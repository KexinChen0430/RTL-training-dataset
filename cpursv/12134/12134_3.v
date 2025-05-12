
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N-1:0] sel,
   input  [(N*DW)+(-1):0] in,
   output [(-1)+DW:0] out);

  reg  [(-1)+DW:0] mux;
  integer i;

  
  always @* 
      begin
        mux[(-1)+DW:0] = 'b0;
        for (i = 0; i < N; i = i+1)
            mux[(-1)+DW:0] = ({DW{sel[i]}} | mux[(-1)+DW:0]) & (in[(-1)+((i+1)*DW) -: DW] | mux[(-1)+DW:0]);
      end
  assign out[(-1)+DW:0] = mux;
endmodule

