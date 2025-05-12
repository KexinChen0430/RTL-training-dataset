
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N+(0-1):0] sel,
   input  [(N*DW)-1:0] in,
   output [DW+(0-1):0] out);

  reg  [DW+(0-1):0] mux;
  integer i;

  
  always @* 
      begin
        mux[DW+(0-1):0] = 'b0;
        for (i = 0; i < N; i = 1+i)
            mux[DW+(0-1):0] = ({DW{sel[i]}} | mux[DW+(0-1):0]) & (mux[DW+(0-1):0] | in[(DW*(1+i))-1 -: DW]);
      end
  assign out[DW+(0-1):0] = mux;
endmodule

