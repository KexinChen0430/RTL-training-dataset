module sub1 #(  
   parameter type T = logic  
   ) (
    input wire T in, 
    output wire T out 
); `HIER_BLOCK  
   assign out = in; 
endmodule  