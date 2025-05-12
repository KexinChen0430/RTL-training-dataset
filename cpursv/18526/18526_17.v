
module nfa_accept_samples_generic_hw_add_17ns_17s_17_4_AddSubnS_5_fadder  #(parameter  N = 5)
  (input  [(-1)+N:0] faa,
   input  [(-1)+N:0] fab,
   input  wire facin,
   output [(-1)+N:0] fas,
   output wire facout);

  assign {facout,fas} = (fab+facin)+faa;
endmodule

