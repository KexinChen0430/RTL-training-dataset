
module nfa_accept_samples_generic_hw_add_6ns_6ns_6_2_AddSubnS_4_fadder_f  #(parameter  N = 3)
  (input  [(-1)+N:0] faa,
   input  [(-1)+N:0] fab,
   input  wire facin,
   output [(-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = faa+(facin+fab);
endmodule

