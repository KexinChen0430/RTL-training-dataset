
module convolve_kernel_adEe_AddSubnS_0_fadder_f  #(parameter  N = 20)
  (input  [N+(-1):0] faa,
   input  [N+(-1):0] fab,
   input  wire facin,
   output [N+(-1):0] fas,
   output wire facout);

  assign {facout,fas} = fab+(facin+faa);
endmodule

