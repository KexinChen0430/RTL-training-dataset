
module nfa_accept_samples_generic_hw_add_6ns_6ns_6_2_AddSubnS_3_fadder  #(parameter  N = 3)
  (input  [(0-1)+N:0] faa,
   input  [(0-1)+N:0] fab,
   input  wire facin,
   output [(0-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = fab+(facin+faa);
endmodule

