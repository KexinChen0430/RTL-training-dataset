module sub
  #(parameter MODE = 0) 
   (
   ifc.out_modport isub, 
   input integer i_value 
   );
`ifdef UNSUPPORTED_MOD_IN_GENS 
   always @* isub.value = i_value; 
`else 
   generate 
   if (MODE == 1) begin 
      always @* isub.valuea = i_value; 
   end
   else if (MODE == 2) begin 
      always @* isub.valueb = i_value; 
   end
   endgenerate 
`endif 
endmodule 