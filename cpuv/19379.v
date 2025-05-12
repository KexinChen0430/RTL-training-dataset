module FDCPE_1 (
  output wire Q, 
  (* clkbuf_sink *) 
  (* invertible_pin = "IS_C_INVERTED" *) 
  input C, 
  input CE, 
  (* invertible_pin = "IS_CLR_INVERTED" *) 
  input CLR, 
  input D, 
  (* invertible_pin = "IS_PRE_INVERTED" *) 
  input PRE 
);
  parameter [0:0] INIT = 1'b0; 
  parameter [0:0] IS_C_INVERTED = 1'b0; 
  parameter [0:0] IS_CLR_INVERTED = 1'b0; 
  parameter [0:0] IS_PRE_INVERTED = 1'b0; 
  wire c = C ^ IS_C_INVERTED; 
  wire clr = CLR ^ IS_CLR_INVERTED; 
  wire pre = PRE ^ IS_PRE_INVERTED; 
  reg qc, qp, qs; 
  initial qc = INIT; 
  initial qp = INIT; 
  initial qs = 0; 
  always @(negedge c, posedge clr) begin
    if (clr)
      qc <= 0; 
    else if (CE)
      qc <= D; 
  end
  always @(negedge c, posedge pre) begin
    if (pre)
      qp <= 1; 
    else if (CE)
      qp <= D; 
  end
  always @* begin
    if (clr)
      qs <= 0; 
    else if (pre)
      qs <= 1; 
  end
  assign Q = qs ? qp : qc; 
endmodule 