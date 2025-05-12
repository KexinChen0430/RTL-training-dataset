
module convolve_kernel_adEe_AddSubnS_0_fadder  #(parameter  N = 22)
  (input  [(0-1)+N:0] faa,
   input  [(0-1)+N:0] fab,
   input  wire facin,
   output [(0-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = faa+(fab+facin);
endmodule

