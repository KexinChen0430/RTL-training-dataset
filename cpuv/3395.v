module LDPE (
  output reg Q, 
  input D, 
  (* invertible_pin = "IS_G_INVERTED" *)
  input G, 
  input GE, 
  (* invertible_pin = "IS_PRE_INVERTED" *)
  input PRE 
);
  parameter [0:0] INIT = 1'b1;
  parameter [0:0] IS_G_INVERTED = 1'b0;
  parameter [0:0] IS_PRE_INVERTED = 1'b0;
  parameter MSGON = "TRUE";
  parameter XON = "TRUE";
  initial Q = INIT;
  wire g = G ^ IS_G_INVERTED;
  wire pre = PRE ^ IS_PRE_INVERTED;
  always @*
    if (pre) Q <= 1'b1;
    else if (GE && g) Q <= D;
endmodule