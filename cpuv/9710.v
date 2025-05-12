module readUSBWireData (RxBitsIn, RxDataInTick, RxBitsOut, SIERxRdyIn, SIERxWEn, fullSpeedRate, TxWireActiveDrive, clk, rst, noActivityTimeOut, RxWireActive, noActivityTimeOutEnable);
input   [1:0] RxBitsIn; 
output  RxDataInTick; 
input   SIERxRdyIn; 
input   clk; 
input   fullSpeedRate; 
input   rst; 
input   TxWireActiveDrive; 
output  [1:0] RxBitsOut; 
output  SIERxWEn; 
output noActivityTimeOut; 
output RxWireActive; 
input  noActivityTimeOutEnable; 
wire   [1:0] RxBitsIn; 
reg    RxDataInTick; 
wire   SIERxRdyIn; 
wire   clk; 
wire   fullSpeedRate; 
wire   rst; 
reg    [1:0] RxBitsOut; 
reg    SIERxWEn; 
reg    noActivityTimeOut; 
reg    RxWireActive; 
wire   noActivityTimeOutEnable; 
reg  [2:0]buffer0; 
reg  [2:0]buffer1; 
reg  [2:0]buffer2; 
reg  [2:0]buffer3; 
reg  [2:0]bufferCnt; 
reg  [1:0]bufferInIndex; 
reg  [1:0]bufferOutIndex; 
reg decBufferCnt; 
reg  [4:0]sampleCnt; 
reg incBufferCnt; 
reg  [1:0]oldRxBitsIn; 
reg [1:0] RxBitsInReg; 
reg [15:0] timeOutCnt; 
reg [7:0] rxActiveCnt; 
reg RxWireEdgeDetect; 
reg RxWireActiveReg; 
reg RxWireActiveReg2; 
reg [1:0] RxBitsInSyncReg1; 
reg [1:0] RxBitsInSyncReg2; 
`define WAIT_BUFFER_NOT_EMPTY 2'b00 
`define WAIT_SIE_RX_READY 2'b01 
`define SIE_RX_WRITE 2'b10 
always @(posedge clk) begin
  RxBitsInSyncReg1 <= RxBitsIn; 
  RxBitsInSyncReg2 <= RxBitsInSyncReg1; 
end
reg [1:0] bufferOutStMachCurrState; 
always @(posedge clk) begin
  if (rst == 1'b1) 
  begin
    bufferCnt <= 3'b000; 
  end
  else begin
    if (incBufferCnt == 1'b1 && decBufferCnt == 1'b0) 
      bufferCnt <= bufferCnt + 1'b1;
    else if (incBufferCnt == 1'b0 && decBufferCnt == 1'b1) 
      bufferCnt <= bufferCnt - 1'b1;
  end
end
always @(posedge clk) begin
  if (rst == 1'b1) 
  begin
    sampleCnt <= 5'b00000; 
    incBufferCnt <= 1'b0; 
    bufferInIndex <= 2'b00; 
    buffer0 <= 3'b000; 
    buffer1 <= 3'b000; 
    buffer2 <= 3'b000; 
    buffer3 <= 3'b000; 
    RxDataInTick <= 1'b0; 
    RxWireEdgeDetect <= 1'b0; 
    RxWireActiveReg <= 1'b0; 
    RxWireActiveReg2 <= 1'b0; 
  end
  else begin
    RxWireActiveReg2 <= RxWireActiveReg; 
    RxBitsInReg <= RxBitsInSyncReg2; 
    oldRxBitsIn <= RxBitsInReg; 
    incBufferCnt <= 1'b0;         
    if ( (TxWireActiveDrive == 1'b0) && (RxBitsInSyncReg2 != RxBitsInReg)) begin  
      sampleCnt <= 5'b00000; 
      RxWireEdgeDetect <= 1'b1;   
      RxWireActiveReg <= 1'b1; 
      rxActiveCnt <= 8'h00; 
    end
    else begin
      sampleCnt <= sampleCnt + 1'b1; 
      RxWireEdgeDetect <= 1'b0; 
      rxActiveCnt <= rxActiveCnt + 1'b1; 
      if ( (fullSpeedRate == 1'b1 && rxActiveCnt == `RX_EDGE_DET_TOUT * `FS_OVER_SAMPLE_RATE)
        || (fullSpeedRate == 1'b0 && rxActiveCnt == `RX_EDGE_DET_TOUT * `LS_OVER_SAMPLE_RATE) )
        RxWireActiveReg <= 1'b0; 
    end
    if ( (fullSpeedRate == 1'b1 && sampleCnt[1:0] == 2'b10) || (fullSpeedRate == 1'b0 && sampleCnt == 5'b10000) )
    begin
      RxDataInTick <= !RxDataInTick; 
      if (TxWireActiveDrive != 1'b1)  
      begin
        incBufferCnt <= 1'b1; 
        bufferInIndex <= bufferInIndex + 1'b1; 
        case (bufferInIndex) 
          2'b00 : buffer0 <= {RxWireActiveReg2, oldRxBitsIn};
          2'b01 : buffer1 <= {RxWireActiveReg2, oldRxBitsIn};
          2'b10 : buffer2 <= {RxWireActiveReg2, oldRxBitsIn};
          2'b11 : buffer3 <= {RxWireActiveReg2, oldRxBitsIn};
        endcase
      end
    end
  end
end
always @(posedge clk) begin
  if (rst == 1'b1) 
  begin
    decBufferCnt <= 1'b0; 
    bufferOutIndex <= 2'b00; 
    RxBitsOut <= 2'b00; 
    SIERxWEn <= 1'b0; 
    bufferOutStMachCurrState <= `WAIT_BUFFER_NOT_EMPTY; 
  end
  else begin
    case (bufferOutStMachCurrState) 
      `WAIT_BUFFER_NOT_EMPTY: 
      begin
        if (bufferCnt != 3'b000) 
          bufferOutStMachCurrState <= `WAIT_SIE_RX_READY; 
      end
      `WAIT_SIE_RX_READY: 
      begin
        if (SIERxRdyIn == 1'b1) 
        begin
          SIERxWEn <= 1'b1; 
          bufferOutStMachCurrState <= `SIE_RX_WRITE; 
          decBufferCnt <= 1'b1; 
          bufferOutIndex <= bufferOutIndex + 1'b1; 
          case (bufferOutIndex) 
            2'b00 : begin RxBitsOut <= buffer0[1:0]; RxWireActive <= buffer0[2]; end
            2'b01 : begin RxBitsOut <= buffer1[1:0]; RxWireActive <= buffer1[2]; end
            2'b10 : begin RxBitsOut <= buffer2[1:0]; RxWireActive <= buffer2[2]; end
            2'b11 : begin RxBitsOut <= buffer3[1:0]; RxWireActive <= buffer3[2]; end
          endcase
        end
      end
      `SIE_RX_WRITE: 
      begin
        SIERxWEn <= 1'b0; 
        decBufferCnt <= 1'b0; 
        bufferOutStMachCurrState <= `WAIT_BUFFER_NOT_EMPTY; 
      end
    endcase
  end
end
always @(posedge clk) begin
  if (rst) begin 
    timeOutCnt <= 16'h0000; 
    noActivityTimeOut <= 1'b0; 
  end
  else begin
    if (TxWireActiveDrive == 1'b1 || RxWireEdgeDetect == 1'b1 || noActivityTimeOutEnable == 1'b0) 
      timeOutCnt <= 16'h0000; 
    else
      timeOutCnt <= timeOutCnt + 1'b1; 
    if ( (fullSpeedRate == 1'b1 && timeOutCnt == `RX_PACKET_TOUT * `FS_OVER_SAMPLE_RATE)
      || (fullSpeedRate == 1'b0 && timeOutCnt == `RX_PACKET_TOUT * `LS_OVER_SAMPLE_RATE) )
      noActivityTimeOut <= 1'b1; 
    else
      noActivityTimeOut <= 1'b0; 
  end
end
endmodule