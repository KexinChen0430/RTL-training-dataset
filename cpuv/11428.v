module inv (
   zn,          
   i            
   );
  parameter DELAY = 1; 
  input i;             
  output zn;           
  assign #DELAY zn = !i;
endmodule 