module grandchild_module ( ); 
parameter		dec_addr_w = 4 ; 
parameter		t0_addr    = 4'd0 ; 
parameter		t1_addr    = 4'd0 ; 
initial begin 
  $display ("GRANDCHILD parameters are: %h %h %h", dec_addr_w, t0_addr, t1_addr) ; 
end 
endmodule 