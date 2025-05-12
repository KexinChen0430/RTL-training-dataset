module SIEReceiver (RxWireDataIn, RxWireDataWEn, clk, connectState, rst); 
input   [1:0] RxWireDataIn; 
input   RxWireDataWEn; 
input   clk; 
input   rst; 
output  [1:0] connectState; 
wire    [1:0] RxWireDataIn; 
wire    RxWireDataWEn; 
wire    clk; 
reg     [1:0] connectState, next_connectState; 
wire    rst; 
reg  [3:0]RXStMachCurrState, next_RXStMachCurrState; 
reg  [7:0]RXWaitCount, next_RXWaitCount; 
reg  [1:0]RxBits, next_RxBits; 
`define WAIT_FS_CONN_CHK_RX_BITS 4'b0000 
`define WAIT_LS_CONN_CHK_RX_BITS 4'b0001 
`define LS_CONN_CHK_RX_BITS 4'b0010 
`define DISCNCT_CHK_RXBITS 4'b0011 
`define WAIT_BIT 4'b0100 
`define START_SRX 4'b0101 
`define FS_CONN_CHK_RX_BITS1 4'b0110 
`define WAIT_LS_DIS_CHK_RX_BITS 4'b0111 
`define WAIT_FS_DIS_CHK_RX_BITS2 4'b1000 
reg [3:0] CurrState_rcvr; 
reg [3:0] NextState_rcvr; 
always @ (RxWireDataIn or RxBits or RXWaitCount or RxWireDataWEn or RXStMachCurrState or connectState or CurrState_rcvr) 
begin : rcvr_NextState 
  NextState_rcvr <= CurrState_rcvr; 
  next_RxBits <= RxBits; 
  next_RXStMachCurrState <= RXStMachCurrState; 
  next_RXWaitCount <= RXWaitCount; 
  next_connectState <= connectState; 
  case (CurrState_rcvr) 
    `WAIT_BIT: 
      if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `WAIT_LOW_SPEED_CONN_ST)) 
      begin
        NextState_rcvr <= `WAIT_LS_CONN_CHK_RX_BITS; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `CONNECT_LOW_SPEED_ST)) 
      begin
        NextState_rcvr <= `LS_CONN_CHK_RX_BITS; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `CONNECT_FULL_SPEED_ST)) 
      begin
        NextState_rcvr <= `FS_CONN_CHK_RX_BITS1; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `WAIT_LOW_SP_DISCONNECT_ST)) 
      begin
        NextState_rcvr <= `WAIT_LS_DIS_CHK_RX_BITS; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `WAIT_FULL_SP_DISCONNECT_ST)) 
      begin
        NextState_rcvr <= `WAIT_FS_DIS_CHK_RX_BITS2; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `DISCONNECT_ST)) 
      begin
        NextState_rcvr <= `DISCNCT_CHK_RXBITS; 
        next_RxBits <= RxWireDataIn; 
      end
      else if ((RxWireDataWEn == 1'b1) && (RXStMachCurrState == `WAIT_FULL_SPEED_CONN_ST)) 
      begin
        NextState_rcvr <= `WAIT_FS_CONN_CHK_RX_BITS; 
        next_RxBits <= RxWireDataIn; 
      end
    `START_SRX: 
    begin
      next_RXStMachCurrState <= `DISCONNECT_ST; 
      next_RXWaitCount <= 8'h00; 
      next_connectState <= `DISCONNECT; 
      next_RxBits <= 2'b00; 
      NextState_rcvr <= `WAIT_BIT; 
    end
    `DISCNCT_CHK_RXBITS: 
      if (RxBits == `ZERO_ONE) 
      begin
        NextState_rcvr <= `WAIT_BIT; 
        next_RXStMachCurrState <= `WAIT_LOW_SPEED_CONN_ST; 
        next_RXWaitCount <= 8'h00; 
      end
      else if (RxBits == `ONE_ZERO) 
      begin
        NextState_rcvr <= `WAIT_BIT; 
        next_RXStMachCurrState <= `WAIT_FULL_SPEED_CONN_ST; 
        next_RXWaitCount <= 8'h00; 
      end
      else
        NextState_rcvr <= `WAIT_BIT; 
    `WAIT_FS_CONN_CHK_RX_BITS: 
    begin
      if (RxBits == `ONE_ZERO) 
      begin
        next_RXWaitCount <= RXWaitCount + 1'b1; 
          if (RXWaitCount == `CONNECT_WAIT_TIME) 
          begin
          next_connectState <= `FULL_SPEED_CONNECT; 
          next_RXStMachCurrState <= `CONNECT_FULL_SPEED_ST; 
          end
      end
      else
      begin
        next_RXStMachCurrState <= `DISCONNECT_ST; 
      end
      NextState_rcvr <= `WAIT_BIT; 
    end
    `WAIT_LS_CONN_CHK_RX_BITS: 
    begin
      if (RxBits == `ZERO_ONE) 
      begin
        next_RXWaitCount <= RXWaitCount + 1'b1; 
          if (RXWaitCount == `CONNECT_WAIT_TIME) 
          begin
          next_connectState <= `LOW_SPEED_CONNECT; 
          next_RXStMachCurrState <= `CONNECT_LOW_SPEED_ST; 
          end
      end
      else
      begin
        next_RXStMachCurrState <= `DISCONNECT_ST; 
      end
      NextState_rcvr <= `WAIT_BIT; 
    end
    `LS_CONN_CHK_RX_BITS: 
    begin
      NextState_rcvr <= `WAIT_BIT; 
      if (RxBits == `SE0) 
      begin
        next_RXStMachCurrState <= `WAIT_LOW_SP_DISCONNECT_ST; 
        next_RXWaitCount <= 0; 
      end
    end
    `FS_CONN_CHK_RX_BITS1: 
    begin
      NextState_rcvr <= `WAIT_BIT; 
      if (RxBits == `SE0) 
      begin
        next_RXStMachCurrState <= `WAIT_FULL_SP_DISCONNECT_ST; 
        next_RXWaitCount <= 0; 
      end
    end
    `WAIT_LS_DIS_CHK_RX_BITS: 
    begin
      NextState_rcvr <= `WAIT_BIT; 
      if (RxBits == `SE0) 
      begin
        next_RXWaitCount <= RXWaitCount + 1'b1; 
          if (RXWaitCount == `DISCONNECT_WAIT_TIME) 
          begin
          next_RXStMachCurrState <= `DISCONNECT_ST; 
          next_connectState <= `DISCONNECT; 
          end
      end
      else
      begin
        next_RXStMachCurrState <= `CONNECT_LOW_SPEED_ST; 
      end
    end
    `WAIT_FS_DIS_CHK_RX_BITS2: 
    begin
      NextState_rcvr <= `WAIT_BIT; 
      if (RxBits == `SE0) 
      begin
        next_RXWaitCount <= RXWaitCount + 1'b1; 
          if (RXWaitCount == `DISCONNECT_WAIT_TIME) 
          begin
          next_RXStMachCurrState <= `DISCONNECT_ST; 
          next_connectState <= `DISCONNECT; 
          end
      end
      else
      begin
        next_RXStMachCurrState <= `CONNECT_FULL_SPEED_ST; 
      end
    end
  endcase 
end 
always @ (posedge clk) 
begin : rcvr_CurrentState 
  if (rst) 
    CurrState_rcvr <= `START_SRX; 
  else
    CurrState_rcvr <= NextState_rcvr; 
end 
always @ (posedge clk) 
begin : rcvr_RegOutput 
  if (rst) 
  begin
    RXStMachCurrState <= `DISCONNECT_ST; 
    RXWaitCount <= 8'h00; 
    RxBits <= 2'b00; 
    connectState <= `DISCONNECT; 
  end
  else
  begin
    RXStMachCurrState <= next_RXStMachCurrState; 
    RXWaitCount <= next_RXWaitCount; 
    RxBits <= next_RxBits; 
    connectState <= next_connectState; 
  end
end 
endmodule 