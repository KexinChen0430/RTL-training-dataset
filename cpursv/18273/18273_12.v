
module convolve_kernel_adEe_AddSubnS_0_fadder  #(parameter  N = 22)
  (input  [N+(0-1):0] faa,
   input  [N+(0-1):0] fab,
   input  wire facin,
   output [N+(0-1):0] fas,
   output wire facout);

  assign {facout,fas} = (faa+facin)+fab;
endmodule

