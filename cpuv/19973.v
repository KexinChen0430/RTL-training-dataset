module EG_PHY_CONFIG(
  output jrstn,
  output [1:0] jrti,
  output jshift,
  output jtck,
  output jtdi,
  output jupdate,
  output [1:0] jscanen,
  output jtms,
  input [1:0] jtdo,
  input [7:0] jtag8_ipa,
  input [7:0] jtag8_ipb,
  output done,
  output highz,
  output cclk,
  input	cclk_en,
  input gsrn_sync_clk,
  input usr_gsrn,
  output dna_dout,
  input	dna_clk,
  input	dna_din,
  input	dna_shift_en,
  input	mboot_rebootn,
  input [7:0]	mboot_dynamic_addr
);
  parameter MBOOT_AUTO_SEL = "DISABLE";
  parameter ADDR_SOURCE_SEL = "STATIC";
  parameter STATIC_ADDR = 8'b0;
  parameter DONE_PERSISTN = "ENABLE";
  parameter INIT_PERSISTN = "ENABLE";
  parameter PROGRAMN_PERSISTN = "DISABLE";
  parameter JTAG_PERSISTN = "DISABLE";
  parameter GSRN_SYNC_SEL = "DISABLE";
  parameter FREQ = "2.5";
  parameter USR_GSRN_EN = "DISABLE";
endmodule