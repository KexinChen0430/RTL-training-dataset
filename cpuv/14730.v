module gclkbuff (
    input  A,   
    output Z    
);
  specify
    (A => Z) = 0; 
  endspecify      
  assign Z = A;   
endmodule