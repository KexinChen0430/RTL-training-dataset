
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N+(0-1):0] sel,
   input  [(DW*N)+(0-1):0] in,
   output [DW-1:0] out);

  reg  [DW-1:0] mux;
  integer i;

  
  always @* 
      begin
        mux[DW-1:0] = 'b0;
        for (i = 0; i < N; i = i+1)
            mux[DW-1:0] = ({DW{sel[i]}} | mux[DW-1:0]) & (mux[DW-1:0] | in[(0-1)+((i+1)*DW) -: DW]);
      end
  assign out[DW-1:0] = mux;
endmodule

