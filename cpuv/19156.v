module sub
   (
   ifc.out_modport isub,
   input clk
   );
   always @(posedge clk)
       isub.valueo <= isub.valuei + 1;
endmodule