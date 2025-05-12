
module ASSP(WB_CLK,WBs_ACK,WBs_RD_DAT,WBs_BYTE_STB,WBs_CYC,WBs_WE,WBs_RD,
            WBs_STB,WBs_ADR,SDMA_Req,SDMA_Sreq,SDMA_Done,SDMA_Active,
            FB_msg_out,FB_Int_Clr,FB_Start,FB_Busy,WB_RST,Sys_PKfb_Rst,
            Sys_Clk0,Sys_Clk0_Rst,Sys_Clk1,Sys_Clk1_Rst,Sys_Pclk,
            Sys_Pclk_Rst,Sys_PKfb_Clk,FB_PKfbData,WBs_WR_DAT,FB_PKfbPush,
            FB_PKfbSOF,FB_PKfbEOF,Sensor_Int,FB_PKfbOverflow,TimeStamp,
            Sys_PSel,SPIm_Paddr,SPIm_PEnable,SPIm_PWrite,SPIm_PWdata,
            SPIm_PReady,SPIm_PSlvErr,SPIm_Prdata,Device_ID);

  input  wire WB_CLK;
  input  wire WBs_ACK;
  input  wire [31:0] WBs_RD_DAT;
  output wire [3:0] WBs_BYTE_STB;
  output wire WBs_CYC;
  output wire WBs_WE;
  output wire WBs_RD;
  output wire WBs_STB;
  output wire [16:0] WBs_ADR;
  input  wire [3:0] SDMA_Req;
  input  wire [3:0] SDMA_Sreq;
  output wire [3:0] SDMA_Done;
  output wire [3:0] SDMA_Active;
  input  wire [3:0] FB_msg_out;
  input  wire [7:0] FB_Int_Clr;
  output wire FB_Start;
  input  wire FB_Busy;
  output wire WB_RST;
  output wire Sys_PKfb_Rst;
  output wire Sys_Clk0;
  output wire Sys_Clk0_Rst;
  output wire Sys_Clk1;
  output wire Sys_Clk1_Rst;
  output wire Sys_Pclk;
  output wire Sys_Pclk_Rst;
  input  wire Sys_PKfb_Clk;
  input  wire [31:0] FB_PKfbData;
  output wire [31:0] WBs_WR_DAT;
  input  wire [3:0] FB_PKfbPush;
  input  wire FB_PKfbSOF;
  input  wire FB_PKfbEOF;
  output wire [7:0] Sensor_Int;
  output wire FB_PKfbOverflow;
  output wire [23:0] TimeStamp;
  input  wire Sys_PSel;
  input  wire [15:0] SPIm_Paddr;
  input  wire SPIm_PEnable;
  input  wire SPIm_PWrite;
  input  wire [31:0] SPIm_PWdata;
  output wire SPIm_PReady;
  output wire SPIm_PSlvErr;
  output wire [31:0] SPIm_Prdata;
  input  wire [15:0] Device_ID;

  assign SPIm_Prdata = (Sys_PSel == 1'b1) ? 32'h00000000 : 32'h00000000;
  assign SPIm_PReady = (Sys_PSel == 1'b1) ? 1'b0 : 1'b0;
  assign SPIm_PSlvErr = (Sys_PSel == 1'b1) ? 1'b0 : 1'b0;
  assign FB_PKfbOverflow = (FB_PKfbPush != 4'b0000) ? 1'b0 : 1'b0;
endmodule

