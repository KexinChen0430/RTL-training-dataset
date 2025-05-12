module FDRSE_1 (
  output reg Q, 
  (* clkbuf_sink *) 
  (* invertible_pin = "IS_C_INVERTED" *) 
  input C, 
  (* invertible_pin = "IS_CE_INVERTED" *) 
  input CE, 
  (* invertible_pin = "IS_D_INVERTED" *) 
  input D, 
  (* invertible_pin = "IS_R_INVERTED" *) 
  input R, 
  (* invertible_pin = "IS_S_INVERTED" *) 
  input S 
);
parameter [0:0] INIT = 1'b0; 
parameter [0:0] IS_C_INVERTED = 1'b0; 
parameter [0:0] IS_CE_INVERTED = 1'b0; 
parameter [0:0] IS_D_INVERTED = 1'b0; 
parameter [0:0] IS_R_INVERTED = 1'b0; 
parameter [0:0] IS_S_INVERTED = 1'b0; 
initial Q <= INIT;
wire c = C ^ IS_C_INVERTED; 
wire ce = CE ^ IS_CE_INVERTED; 
wire d = D ^ IS_D_INVERTED; 
wire r = R ^ IS_R_INVERTED; 
wire s = S ^ IS_S_INVERTED; 
always @(negedge c)
  if (r) 
    Q <= 0; 
  else if (s) 
    Q <= 1; 
  else if (ce) 
    Q <= d; 
endmodule