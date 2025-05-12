module MULT_AND (
  output LO, 
  input I0,  
  input I1   
);
  assign LO = I0 & I1;
endmodule