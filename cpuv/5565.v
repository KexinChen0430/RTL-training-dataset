module spiCtrl (
    clk, readWriteSDBlockRdy, readWriteSDBlockReq, rst, rxDataRdy, rxDataRdyClr, 
    SDInitReq, spiCS_n, spiTransCtrl, spiTransSts, spiTransType, txDataWen
);
input   clk; 
input   readWriteSDBlockRdy; 
input   rst; 
input   rxDataRdy; 
input   spiTransCtrl; 
input   [1:0]spiTransType; 
output  [1:0]readWriteSDBlockReq; 
output  rxDataRdyClr; 
output  SDInitReq; 
output  spiCS_n; 
output  spiTransSts; 
output  txDataWen; 
wire    clk;
wire    readWriteSDBlockRdy;
reg     [1:0]readWriteSDBlockReq, next_readWriteSDBlockReq; 
wire    rst;
wire    rxDataRdy;
reg     rxDataRdyClr, next_rxDataRdyClr; 
reg     SDInitReq, next_SDInitReq; 
reg     spiCS_n, next_spiCS_n; 
wire    spiTransCtrl;
reg     spiTransSts, next_spiTransSts; 
wire    [1:0]spiTransType;
reg     txDataWen, next_txDataWen; 
`define ST_S_CTRL 3'b000
`define WT_S_CTRL_REQ 3'b001
`define WT_FIN1 3'b010
`define DIR_ACC 3'b011
`define INIT 3'b100
`define WT_FIN2 3'b101
`define RW 3'b110
`define WT_FIN3 3'b111
reg [2:0]CurrState_spiCtrlSt, NextState_spiCtrlSt;
always @ (spiTransCtrl or rxDataRdy or spiTransType or readWriteSDBlockRdy or readWriteSDBlockReq or txDataWen or SDInitReq or rxDataRdyClr or spiTransSts or spiCS_n or CurrState_spiCtrlSt)
begin
  NextState_spiCtrlSt <= CurrState_spiCtrlSt;
  next_readWriteSDBlockReq <= readWriteSDBlockReq;
  next_txDataWen <= txDataWen;
  next_SDInitReq <= SDInitReq;
  next_rxDataRdyClr <= rxDataRdyClr;
  next_spiTransSts <= spiTransSts;
  next_spiCS_n <= spiCS_n;
  case (CurrState_spiCtrlSt)  
    `ST_S_CTRL: 
    begin
      next_readWriteSDBlockReq <= `NO_BLOCK_REQ;
      next_txDataWen <= 1'b0;
      next_SDInitReq <= 1'b0;
      next_rxDataRdyClr <= 1'b0;
      next_spiTransSts <= `TRANS_NOT_BUSY;
      next_spiCS_n <= 1'b1;
      NextState_spiCtrlSt <= `WT_S_CTRL_REQ;
    end
    `WT_S_CTRL_REQ: 
    begin
      next_rxDataRdyClr <= 1'b0;
      next_spiTransSts <= `TRANS_NOT_BUSY;
      if ((spiTransCtrl == `TRANS_START) && (spiTransType == `INIT_SD))
      begin
        NextState_spiCtrlSt <= `INIT;
        next_spiTransSts <= `TRANS_BUSY;
        next_SDInitReq <= 1'b1;
        next_txDataWen <= 1'b1;
        next_spiCS_n <= 1'b0;
      end
      else if ((spiTransCtrl == `TRANS_START) && (spiTransType == `RW_WRITE_SD_BLOCK))
      begin
        NextState_spiCtrlSt <= `RW;
        next_spiTransSts <= `TRANS_BUSY;
        next_readWriteSDBlockReq <= `WRITE_SD_BLOCK;
      end
      else if ((spiTransCtrl == `TRANS_START) && (spiTransType == `RW_READ_SD_BLOCK))
      begin
        NextState_spiCtrlSt <= `RW;
        next_spiTransSts <= `TRANS_BUSY;
        next_readWriteSDBlockReq <= `READ_SD_BLOCK;
      end
      else if ((spiTransCtrl == `TRANS_START) && (spiTransType == `DIRECT_ACCESS))
      begin
        NextState_spiCtrlSt <= `DIR_ACC;
        next_spiTransSts <= `TRANS_BUSY;
        next_txDataWen <= 1'b1;
        next_spiCS_n <= 1'b0;
      end
    end
    `WT_FIN1: 
    begin
      if (rxDataRdy == 1'b1)
      begin
        NextState_spiCtrlSt <= `WT_S_CTRL_REQ;
        next_rxDataRdyClr <= 1'b1;
        next_spiCS_n <= 1'b1;
      end
    end
    `DIR_ACC: 
    begin
      next_txDataWen <= 1'b0;
      NextState_spiCtrlSt <= `WT_FIN1;
    end
    `INIT: 
    begin
      next_txDataWen <= 1'b0;
      NextState_spiCtrlSt <= `WT_FIN2;
    end
    `WT_FIN2: 
    begin
      if (rxDataRdy == 1'b1)
      begin
        next_SDInitReq <= 1'b0;
        NextState_spiCtrlSt <= `WT_S_CTRL_REQ;
        next_rxDataRdyClr <= 1'b1;
      end
    end
    `RW: 
    begin
      next_readWriteSDBlockReq <= `NO_BLOCK_REQ;
      NextState_spiCtrlSt <= `WT_FIN3;
    end
    `WT_FIN3: 
    begin
      if (readWriteSDBlockRdy == 1'b1)
      begin
        NextState_spiCtrlSt <= `WT_S_CTRL_REQ;
      end
    end
  endcase
end
always @ (posedge clk)
begin
  if (rst == 1'b1)
    CurrState_spiCtrlSt <= `ST_S_CTRL;
  else
    CurrState_spiCtrlSt <= NextState_spiCtrlSt;
end
always @ (posedge clk)
begin
  if (rst == 1'b1)
  begin
    readWriteSDBlockReq <= `NO_BLOCK_REQ;
    txDataWen <= 1'b0;
    SDInitReq <= 1'b0;
    rxDataRdyClr <= 1'b0;
    spiTransSts <= `TRANS_NOT_BUSY;
    spiCS_n <= 1'b1;
  end
  else
  begin
    readWriteSDBlockReq <= next_readWriteSDBlockReq;
    txDataWen <= next_txDataWen;
    SDInitReq <= next_SDInitReq;
    rxDataRdyClr <= next_rxDataRdyClr;
    spiTransSts <= next_spiTransSts;
    spiCS_n <= next_spiCS_n;
  end
end
endmodule