module LDCPE (
  output reg Q,
  (* invertible_pin = "IS_CLR_INVERTED" *)
  input CLR,
  (* invertible_pin = "IS_D_INVERTED" *)
  input D,
  (* invertible_pin = "IS_G_INVERTED" *)
  input G,
  (* invertible_pin = "IS_GE_INVERTED" *)
  input GE,
  (* invertible_pin = "IS_PRE_INVERTED" *)
  input PRE
);
  parameter [0:0] INIT = 1'b1;
  parameter [0:0] IS_CLR_INVERTED = 1'b0;
  parameter [0:0] IS_D_INVERTED = 1'b0;
  parameter [0:0] IS_G_INVERTED = 1'b0;
  parameter [0:0] IS_GE_INVERTED = 1'b0;
  parameter [0:0] IS_PRE_INVERTED = 1'b0;
  initial Q = INIT;
  wire d = D ^ IS_D_INVERTED;
  wire g = G ^ IS_G_INVERTED;
  wire ge = GE ^ IS_GE_INVERTED;
  wire clr = CLR ^ IS_CLR_INVERTED;
  wire pre = PRE ^ IS_PRE_INVERTED;
  always @*
    if (clr) Q <= 1'b0;
    else if (pre) Q <= 1'b1;
    else if (ge && g) Q <= d;
endmodule