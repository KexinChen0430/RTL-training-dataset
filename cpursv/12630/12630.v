
module module_1(processing_system7_0_MIO,processing_system7_0_PS_SRSTB_pin,
                processing_system7_0_PS_CLK_pin,
                processing_system7_0_PS_PORB_pin,processing_system7_0_DDR_Clk,
                processing_system7_0_DDR_Clk_n,processing_system7_0_DDR_CKE,
                processing_system7_0_DDR_CS_n,processing_system7_0_DDR_RAS_n,
                processing_system7_0_DDR_CAS_n,
                processing_system7_0_DDR_WEB_pin,
                processing_system7_0_DDR_BankAddr,
                processing_system7_0_DDR_Addr,processing_system7_0_DDR_ODT,
                processing_system7_0_DDR_DRSTB,processing_system7_0_DDR_DQ,
                processing_system7_0_DDR_DM,processing_system7_0_DDR_DQS,
                processing_system7_0_DDR_DQS_n,processing_system7_0_DDR_VRN,
                processing_system7_0_DDR_VRP,coprocessor_0_LED_OUT_pin,
                coprocessor_0_SW_IN_pin,coprocessor_0_BTN_IN_pin);

  inout  [53:0] processing_system7_0_MIO;
  input  processing_system7_0_PS_SRSTB_pin;
  input  processing_system7_0_PS_CLK_pin;
  input  processing_system7_0_PS_PORB_pin;
  inout  processing_system7_0_DDR_Clk;
  inout  processing_system7_0_DDR_Clk_n;
  inout  processing_system7_0_DDR_CKE;
  inout  processing_system7_0_DDR_CS_n;
  inout  processing_system7_0_DDR_RAS_n;
  inout  processing_system7_0_DDR_CAS_n;
  output processing_system7_0_DDR_WEB_pin;
  inout  [2:0] processing_system7_0_DDR_BankAddr;
  inout  [14:0] processing_system7_0_DDR_Addr;
  inout  processing_system7_0_DDR_ODT;
  inout  processing_system7_0_DDR_DRSTB;
  inout  [31:0] processing_system7_0_DDR_DQ;
  inout  [3:0] processing_system7_0_DDR_DM;
  inout  [3:0] processing_system7_0_DDR_DQS;
  inout  [3:0] processing_system7_0_DDR_DQS_n;
  inout  processing_system7_0_DDR_VRN;
  inout  processing_system7_0_DDR_VRP;
  output [7:0] coprocessor_0_LED_OUT_pin;
  input  [7:0] coprocessor_0_SW_IN_pin;
  input  [4:0] coprocessor_0_BTN_IN_pin;


endmodule

