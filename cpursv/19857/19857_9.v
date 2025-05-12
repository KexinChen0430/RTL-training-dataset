
module nfa_accept_samples_generic_hw_add_16ns_16ns_16_4_AddSubnS_3_fadder_f  #(parameter  N = 4)
  (input  [(-1)+N:0] faa,
   input  [(-1)+N:0] fab,
   input  wire facin,
   output [(-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = fab+(faa+facin);
endmodule

