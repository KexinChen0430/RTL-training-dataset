module) 
  output		clk, 
  output		reset, 
  output		start, 
  input [7:0]		count, 
  my_svi.master		my_svi_port, 
  my_svi		my_svi_noport, 
  my_svi		my_svi_noport_upper_decl 
   );
endmodule 