module EG_PHY_DDR_8M_16(
  input clk,
  input clk_n,
  input ras_n,
  input cas_n,
  input we_n,
  input cs_n,
  input [11:0] addr,
  input [1:0] ba,
  inout [15:0] dq,
  input ldqs,
  input udqs,
  input ldm,
  input udm,
  input cke
);
endmodule