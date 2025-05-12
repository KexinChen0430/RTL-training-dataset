module) 
  output [7:0]		count, 
  input			clk, 
  input			reset, 
  input			start, 
  my_svi.master		my_svi_port, 
  my_svi		my_svi_noport, 
  my_svi		my_svi_noport_upper_decl 
   ); 
endmodule 