module arbiter (clk, rst, request, acknowledge, grant, grant_valid, grant_encoded);
  input [3:0] acknowledge; 
  input clk; 
  input [3:0] request; 
  input rst; 
  output [3:0] grant; 
  output [1:0] grant_encoded; 
  output grant_valid; 
endmodule