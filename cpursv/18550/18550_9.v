
module nfa_accept_samples_generic_hw_add_17ns_17s_17_4_AddSubnS_5_fadder_f  #(parameter  N = 1<<<1)
  (input  [N+(0-1):0] faa,
   input  [N+(0-1):0] fab,
   input  wire facin,
   output [N+(0-1):0] fas,
   output wire facout);

  assign {facout,fas} = (faa+facin)+fab;
endmodule

