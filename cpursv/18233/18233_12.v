
module convolve_kernel_adEe_AddSubnS_0_fadder_f  #(parameter  N = 20)
  (input  [(0-1)+N:0] faa,
   input  [(0-1)+N:0] fab,
   input  wire facin,
   output [(0-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = fab+(facin+faa);
endmodule

