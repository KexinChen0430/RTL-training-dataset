module SOFTransmit (SOFEnable, SOFSent, SOFSyncEn, SOFTimerClr, SOFTimer, clk, rst, sendPacketArbiterGnt, sendPacketArbiterReq, sendPacketRdy, sendPacketWEn, fullSpeedRate);
input   SOFEnable;		
input   SOFSyncEn;
input   [15:0] SOFTimer;
input   clk;
input   rst;
input   sendPacketArbiterGnt;
input   sendPacketRdy;
output  SOFSent;		
output  SOFTimerClr;		
output  sendPacketArbiterReq;
output  sendPacketWEn;
input   fullSpeedRate;
wire    SOFEnable;
reg     SOFSent, next_SOFSent;
wire    SOFSyncEn;
reg     SOFTimerClr, next_SOFTimerClr;
wire    [15:0] SOFTimer;
wire    clk;
wire    rst;
wire    sendPacketArbiterGnt;
reg     sendPacketArbiterReq, next_sendPacketArbiterReq;
wire    sendPacketRdy;
reg     sendPacketWEn, next_sendPacketWEn;
reg     [15:0] SOFNearTime;
reg  [7:0]i, next_i;
`define START_STX 3'b000
`define WAIT_SOF_NEAR 3'b001
`define WAIT_SP_GNT 3'b010
`define WAIT_SOF_NOW 3'b011
`define SOF_FIN 3'b100
`define DLY_SOF_CHK1 3'b101
`define DLY_SOF_CHK2 3'b110
reg [2:0] CurrState_SOFTx;
reg [2:0] NextState_SOFTx;
always @ (i or SOFTimer or SOFSyncEn or SOFEnable or sendPacketArbiterGnt or sendPacketRdy or sendPacketArbiterReq or sendPacketWEn or SOFTimerClr or SOFSent or CurrState_SOFTx)
begin : SOFTx_NextState
  NextState_SOFTx <= CurrState_SOFTx;
  next_sendPacketArbiterReq <= sendPacketArbiterReq;
  next_sendPacketWEn <= sendPacketWEn;
  next_SOFTimerClr <= SOFTimerClr;
  next_SOFSent <= SOFSent;
  next_i <= i;
  case (CurrState_SOFTx)
    `START_STX:
      NextState_SOFTx <= `WAIT_SOF_NEAR;
    `WAIT_SOF_NEAR:
      if (SOFTimer >= SOFNearTime  ||
        (SOFSyncEn == 1'b1 &&
        SOFEnable == 1'b1))
      begin
        NextState_SOFTx <= `WAIT_SP_GNT;
        next_sendPacketArbiterReq <= 1'b1;
      end
    `WAIT_SP_GNT:
      if (sendPacketArbiterGnt == 1'b1 && sendPacketRdy == 1'b1)
        NextState_SOFTx <= `WAIT_SOF_NOW;
    `WAIT_SOF_NOW:
      if (SOFTimer >= `SOF_TX_TIME)
      begin
        NextState_SOFTx <= `SOF_FIN;
        next_sendPacketWEn <= 1'b1;
        next_SOFTimerClr <= 1'b1;
        next_SOFSent <= 1'b1;
      end
      else if (SOFEnable == 1'b0)
      begin
        NextState_SOFTx <= `SOF_FIN;
        next_SOFTimerClr <= 1'b1;
      end
    `SOF_FIN:
    begin
      next_sendPacketWEn <= 1'b0;
      next_SOFTimerClr <= 1'b0;
      next_SOFSent <= 1'b0;
      if (sendPacketRdy == 1'b1)
      begin
        NextState_SOFTx <= `DLY_SOF_CHK1;
        next_i <= 8'h00;
      end
    end
    `DLY_SOF_CHK1:
    begin
      next_i <= i + 1'b1;
      if (i==8'hff)
      begin
        NextState_SOFTx <= `DLY_SOF_CHK2;
        next_sendPacketArbiterReq <= 1'b0;
        next_i <= 8'h00;
      end
    end
    `DLY_SOF_CHK2:
    begin
      next_i <= i + 1'b1;
      if (i==8'hff)
        NextState_SOFTx <= `WAIT_SOF_NEAR;
    end
  endcase
end
always @ (posedge clk)
begin : SOFTx_CurrentState
  if (rst)
    CurrState_SOFTx <= `START_STX;
  else
    CurrState_SOFTx <= NextState_SOFTx;
end
always @ (posedge clk)
begin : SOFTx_RegOutput
  if (rst)
  begin
    i <= 8'h00;
    SOFSent <= 1'b0;
    SOFTimerClr <= 1'b0;
    sendPacketArbiterReq <= 1'b0;
    sendPacketWEn <= 1'b0;
    SOFNearTime <= 16'h0000;
  end
  else
  begin
    i <= next_i;
    SOFSent <= next_SOFSent;
    SOFTimerClr <= next_SOFTimerClr;
    sendPacketArbiterReq <= next_sendPacketArbiterReq;
    sendPacketWEn <= next_sendPacketWEn;
    if (fullSpeedRate == 1'b1)
      SOFNearTime <= `SOF_TX_TIME - `SOF_TX_MARGIN;
    else
      SOFNearTime <= `SOF_TX_TIME - `SOF_TX_MARGIN_LOW_SPEED;
  end
end
endmodule