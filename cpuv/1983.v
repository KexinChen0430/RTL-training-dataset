module glbl(); 
`ifdef PUB_FUNC 
   reg GSR; 
   task setGSR; 
      input value; 
      GSR = value; 
   endtask 
`else 
   reg GSR ; 
`endif 
endmodule 