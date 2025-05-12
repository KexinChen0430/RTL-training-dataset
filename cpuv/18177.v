module ORN
(
  A,    
  B,    
  Z     
);
  input A;  
  input B;  
  output Z; 
  assign Z = A | ~B;
endmodule 