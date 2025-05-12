module ROM128X1 (
  output O,      
  input A0,      
  input A1,      
  input A2,      
  input A3,      
  input A4,      
  input A5,      
  input A6       
);
  parameter [127:0] INIT = 128'h0;
  assign O = INIT[{A6, A5, A4, A3, A2, A1, A0}];
endmodule 