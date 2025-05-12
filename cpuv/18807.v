module  top_test(); 
   testmux #(.WIDTH(  16  )) testmux_boo 
     (); 
   testmux  testmux_defaultwidth 
     (); 
   testmux #(.IGNORE((1)), 
	     .WIDTH(  16  ), 
	     .IGNORE2(2)) 
     testmux_boo 
       (); 
   testmux #(.IGNORE((1)), 
	     .WIDTH(WIDTH),   
	     .IGNORE2(2)) 
     testmux_boo 
       (); 
endmodule 