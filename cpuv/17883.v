module t_tri2 (   
   t2,                        
   d, oe                      
   );
   output t2;                 
   input  d;                  
   input  oe;                 
   tri1   t2;                 
   bufif1 (t2, d, oe);        
endmodule                     