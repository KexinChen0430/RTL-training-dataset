module my_module( 
   output logic      clk, 
   output logic      reset, 
   output logic      start, 
   input logic [7:0] count, 
   my_svi.master my_svi_port, 
   my_svi my_svi_noport, 
   my_svi my_svi_noport_upper_decl 
   );
endmodule 