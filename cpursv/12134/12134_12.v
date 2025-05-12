
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N+(-1):0] sel,
   input  [(N*DW)-1:0] in,
   output [DW-1:0] out);

  reg  [DW-1:0] mux;
  integer i;

  
  always @* 
      begin
        mux[DW-1:0] = 'b0;
        for (i = 0; i < N; i = 1+i)
            mux[DW-1:0] = ({DW{sel[i]}} & in[(-1)+(DW*(1+i)) -: DW]) | mux[DW-1:0];
      end
  assign out[DW-1:0] = mux;
endmodule

