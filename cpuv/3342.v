module ROM32X1 (
  output O,      
  input A0,      
  input A1,      
  input A2,      
  input A3,      
  input A4       
);
  parameter [31:0] INIT = 32'h0;
  assign O = INIT[{A4, A3, A2, A1, A0}];
endmodule 