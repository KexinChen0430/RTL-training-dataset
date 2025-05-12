
module oh_mux  #(parameter  DW = 1, N = 1)
  (input  [N+(0-1):0] sel,
   input  [(0-1)+(N*DW):0] in,
   output [(0-1)+DW:0] out);

  reg  [(0-1)+DW:0] mux;
  integer i;

  
  always @* 
      begin
        mux[(0-1)+DW:0] = 'b0;
        for (i = 0; i < N; i = i+1)
            mux[(0-1)+DW:0] = (in[(0-1)+(DW*(i+1)) -: DW] | mux[(0-1)+DW:0]) & (mux[(0-1)+DW:0] | {DW{sel[i]}});
      end
  assign out[(0-1)+DW:0] = mux;
endmodule

