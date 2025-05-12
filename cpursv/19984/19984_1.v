
module EG_PHY_MSLICE(input  [1:0] a,
                     input  [1:0] b,
                     input  [1:0] c,
                     input  [1:0] d,
                     input  [1:0] mi,
                     input  clk,
                     input  ce,
                     input  sr,
                     input  fci,
                     output [1:0] f,
                     output [1:0] fx,
                     output [1:0] q,
                     output fco,
                     input  dpram_mode,
                     input  [1:0] dpram_di,
                     input  dpram_we,
                     input  dpram_wclk,
                     input  [3:0] dpram_waddr);

  parameter  INIT_LUT0 = 16'h0000;
  parameter  INIT_LUT1 = 16'h0000;
  parameter  MODE = LOGIC;
  parameter  ALUTYPE = ADD;
  parameter  MSFXMUX = OFF;
  parameter  GSR = ENABLE;
  parameter  TESTMODE = OFF;
  parameter  CEMUX = CE;
  parameter  SRMUX = SR;
  parameter  CLKMUX = CLK;
  parameter  SRMODE = ASYNC;
  parameter  DFFMODE = FF;
  parameter  REG0_SD = MI;
  parameter  REG1_SD = MI;
  parameter  REG0_REGSET = SET;
  parameter  REG1_REGSET = SET;


endmodule

