
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N-1:0] sel,
   input  [(N*DW)-1:0] in,
   output [(0-1)+DW:0] out);

  reg  [(0-1)+DW:0] mux;
  integer i;

  
  always @* 
      begin
        mux[(0-1)+DW:0] = 'b0;
        for (i = 0; i < N; i = 1+i)
            mux[(0-1)+DW:0] = (mux[(0-1)+DW:0] | (in[((1+i)*DW)-1 -: DW] | (({DW{sel[i]}} & mux[(0-1)+DW:0]) | ({DW{sel[i]}} & in[((1+i)*DW)-1 -: DW])))) & (mux[(0-1)+DW:0] | {DW{sel[i]}});
      end
  assign out[(0-1)+DW:0] = mux;
endmodule

