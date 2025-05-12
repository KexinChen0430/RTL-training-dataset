
module nfa_accept_samples_generic_hw_add_14ns_14ns_14_4_AddSubnS_4_fadder_f  #(parameter  N = 1+1)
  (input  [(0-1)+N:0] faa,
   input  [(0-1)+N:0] fab,
   input  wire facin,
   output [(0-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = facin+(fab+faa);
endmodule

