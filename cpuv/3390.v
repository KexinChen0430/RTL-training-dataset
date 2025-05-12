module LDCE (
  output reg Q, 
  (* invertible_pin = "IS_CLR_INVERTED" *) 
  input CLR, 
  input D, 
  (* invertible_pin = "IS_G_INVERTED" *) 
  input G, 
  input GE 
);
  parameter [0:0] INIT = 1'b0; 
  parameter [0:0] IS_CLR_INVERTED = 1'b0; 
  parameter [0:0] IS_G_INVERTED = 1'b0; 
  parameter MSGON = "TRUE"; 
  parameter XON = "TRUE"; 
  initial Q = INIT;
  wire clr = CLR ^ IS_CLR_INVERTED; 
  wire g = G ^ IS_G_INVERTED; 
  always @*
    if (clr) Q <= 1'b0; 
    else if (GE && g) Q <= D; 
endmodule