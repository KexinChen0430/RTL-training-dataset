module rc_pcs_pipe_top (
input wire       refclkp,
   input wire       refclkn,
   input wire       RESET_n,
   input wire       ffc_quad_rst,
   input wire [1:0] PowerDown,
   input wire       TxDetectRx_Loopback,
   output wire   PCLK,
   output wire   PCLK_by_2,
   output reg    PhyStatus,
   output wire   ffs_plol,
   input wire             hdinp0,
   input wire             hdinn0,
   output wire            hdoutp0,
   output wire            hdoutn0,
   input wire [7:0]  TxData_0,
   input wire [0:0]   TxDataK_0,
   input wire                   TxCompliance_0,
   input wire                   TxElecIdle_0,
   input wire                   RxPolarity_0,
   input wire                   scisel_0,
   input wire                   scien_0,
   output wire [7:0] RxData_0,
   output wire [0:0]  RxDataK_0,
   output wire                  RxValid_0,
   output wire                  RxElecIdle_0,
   output wire [2:0]            RxStatus_0,
   output wire                  ffs_rlol_ch0,
   input [7:0]              sciwritedata,
   input [5:0]              sciaddress,
   input                    sciselaux,
   input                    scienaux,
   input                    scird,
   input                    sciwstn,
   output[7:0]              scireaddata,
   input wire               phy_l0,
   input wire [3:0]         phy_cfgln,
   input wire               ctc_disable,
   input wire               flip_lanes
  )
;
endmodule