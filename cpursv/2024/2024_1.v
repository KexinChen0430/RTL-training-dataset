
module USBTxWireArbiter(SIETxCtrl,SIETxData,SIETxFSRate,SIETxGnt,SIETxReq,SIETxWEn,
                        TxBits,TxCtl,TxFSRate,USBWireRdyIn,USBWireRdyOut,USBWireWEn,
                        clk,prcTxByteCtrl,prcTxByteData,prcTxByteFSRate,prcTxByteGnt,
                        prcTxByteReq,prcTxByteWEn,rst);

  input  SIETxCtrl;
  input  [1:0] SIETxData;
  input  SIETxFSRate;
  input  SIETxReq;
  input  SIETxWEn;
  input  USBWireRdyIn;
  input  clk;
  input  prcTxByteCtrl;
  input  [1:0] prcTxByteData;
  input  prcTxByteFSRate;
  input  prcTxByteReq;
  input  prcTxByteWEn;
  input  rst;
  output SIETxGnt;
  output [1:0] TxBits;
  output TxCtl;
  output TxFSRate;
  output USBWireRdyOut;
  output USBWireWEn;
  output prcTxByteGnt;
  wire SIETxCtrl;
  wire [1:0] SIETxData;
  wire SIETxFSRate;
  reg  SIETxGnt,next_SIETxGnt;
  wire SIETxReq;
  wire SIETxWEn;
  reg  [1:0] TxBits,next_TxBits;
  reg  TxCtl,next_TxCtl;
  reg  TxFSRate,next_TxFSRate;
  wire USBWireRdyIn;
  reg  USBWireRdyOut,next_USBWireRdyOut;
  reg  USBWireWEn,next_USBWireWEn;
  wire clk;
  wire prcTxByteCtrl;
  wire [1:0] prcTxByteData;
  wire prcTxByteFSRate;
  reg  prcTxByteGnt,next_prcTxByteGnt;
  wire prcTxByteReq;
  wire prcTxByteWEn;
  wire rst;
  reg  muxSIENotPTXB,next_muxSIENotPTXB;
  reg  [1:0] CurrState_txWireArb;
  reg  [1:0] NextState_txWireArb;

  
  always @(USBWireRdyIn)
      begin
        USBWireRdyOut <= USBWireRdyIn;
      end
  
  always @(muxSIENotPTXB or SIETxWEn or SIETxData or SIETxCtrl or prcTxByteWEn or prcTxByteData or prcTxByteCtrl or SIETxFSRate or prcTxByteFSRate)
      begin
        if (muxSIENotPTXB == 1'b1) 
          begin
            USBWireWEn <= SIETxWEn;
            TxBits <= SIETxData;
            TxCtl <= SIETxCtrl;
            TxFSRate <= SIETxFSRate;
          end
        else 
          begin
            USBWireWEn <= prcTxByteWEn;
            TxBits <= prcTxByteData;
            TxCtl <= prcTxByteCtrl;
            TxFSRate <= prcTxByteFSRate;
          end
      end
  
  always @(prcTxByteReq or SIETxReq or prcTxByteGnt or muxSIENotPTXB or SIETxGnt or CurrState_txWireArb)
      begin : txWireArb_NextState
        NextState_txWireArb <= CurrState_txWireArb;
        next_prcTxByteGnt <= prcTxByteGnt;
        next_muxSIENotPTXB <= muxSIENotPTXB;
        next_SIETxGnt <= SIETxGnt;
        case (CurrState_txWireArb)

          2'b00: NextState_txWireArb <= 2'b01;

          2'b01: if (prcTxByteReq == 1'b1) 
                begin
                  NextState_txWireArb <= 2'b10;
                  next_prcTxByteGnt <= 1'b1;
                  next_muxSIENotPTXB <= 1'b0;
                end
              else if (SIETxReq == 1'b1) 
                begin
                  NextState_txWireArb <= 2'b11;
                  next_SIETxGnt <= 1'b1;
                  next_muxSIENotPTXB <= 1'b1;
                end
                

          2'b10: if (prcTxByteReq == 1'b0) 
                begin
                  NextState_txWireArb <= 2'b01;
                  next_prcTxByteGnt <= 1'b0;
                end
                

          2'b11: if (SIETxReq == 1'b0) 
                begin
                  NextState_txWireArb <= 2'b01;
                  next_SIETxGnt <= 1'b0;
                end
                

        endcase

      end
  
  always @(posedge clk)
      begin : txWireArb_CurrentState
        if (rst) CurrState_txWireArb <= 2'b00;
        else CurrState_txWireArb <= NextState_txWireArb;
      end
  
  always @(posedge clk)
      begin : txWireArb_RegOutput
        if (rst) 
          begin
            muxSIENotPTXB <= 1'b0;
            prcTxByteGnt <= 1'b0;
            SIETxGnt <= 1'b0;
          end
        else 
          begin
            muxSIENotPTXB <= next_muxSIENotPTXB;
            prcTxByteGnt <= next_prcTxByteGnt;
            SIETxGnt <= next_SIETxGnt;
          end
      end
endmodule

