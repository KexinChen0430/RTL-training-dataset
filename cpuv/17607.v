module Mult_interconnect(A,B); 
   parameter num_inputs = 0; 
   input [num_inputs-1:0]A; 
   output [num_inputs-1:0] B; 
   specify 
      (A=>B)=""; 
   endspecify 
   assign B = A; 
endmodule 