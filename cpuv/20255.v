module grandchild_module #(dec_addr_w, t0_addr, t1_addr) my_grandchild_module ( );
initial begin
  $display ("CHILD parameters are: %h %h %h", dec_addr_w, t0_addr, t1_addr) ;
end
endmodule