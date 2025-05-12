module glbl(); 
`ifdef PUB_FUNC 
   reg GSR; 
   task setGSR; 
`ifdef ATTRIBUTES 
`endif
      input value; 
      GSR = value; 
   endtask 
`else 
 `ifdef ATTRIBUTES 
   reg GSR ; 
 `else 
   reg GSR; 
 `endif
`endif
endmodule 