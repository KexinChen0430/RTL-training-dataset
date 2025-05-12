module BUFTSHD2X (A, E, Z); 
input  A ; 
input  E ; 
output Z ; 
   bufif1 (Z, A, E); 
   specify
     (A *> Z) = (0, 0); 
     (E *> Z) = (0, 0, 0, 0, 0, 0); 
   endspecify 
endmodule 