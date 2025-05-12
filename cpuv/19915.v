module EG_PHY_CLKDIV(
  output clkdiv1,
  output clkdivx,
  input clki,
  input rst,
  input rls
);
  parameter GSR = "DISABLE";
  parameter DIV = 2;
endmodule