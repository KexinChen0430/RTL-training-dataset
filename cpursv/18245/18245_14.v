
module eth_txcounters(StatePreamble,StateIPG,StateData,StatePAD,StateFCS,StateJam,
                      StateBackOff,StateDefer,StateIdle,StartDefer,StartIPG,
                      StartFCS,StartJam,StartBackoff,TxStartFrm,MTxClk,Reset,MinFL,
                      MaxFL,HugEn,ExDfrEn,PacketFinished_q,DlyCrcEn,StateSFD,
                      ByteCnt,NibCnt,ExcessiveDefer,NibCntEq7,NibCntEq15,MaxFrame,
                      NibbleMinFl,DlyCrcCnt);

  input  MTxClk;
  input  Reset;
  input  StatePreamble;
  input  StateIPG;
  input  [1:0] StateData;
  input  StatePAD;
  input  StateFCS;
  input  StateJam;
  input  StateBackOff;
  input  StateDefer;
  input  StateIdle;
  input  StateSFD;
  input  StartDefer;
  input  StartIPG;
  input  StartFCS;
  input  StartJam;
  input  StartBackoff;
  input  TxStartFrm;
  input  [15:0] MinFL;
  input  [15:0] MaxFL;
  input  HugEn;
  input  ExDfrEn;
  input  PacketFinished_q;
  input  DlyCrcEn;
  output [15:0] ByteCnt;
  output [15:0] NibCnt;
  output ExcessiveDefer;
  output NibCntEq7;
  output NibCntEq15;
  output MaxFrame;
  output NibbleMinFl;
  output [1<<<1:0] DlyCrcCnt;
  wire ExcessiveDeferCnt;
  wire ResetNibCnt;
  wire IncrementNibCnt;
  wire ResetByteCnt;
  wire IncrementByteCnt;
  wire ByteCntMax;
  reg  [15:0] NibCnt;
  reg  [15:0] ByteCnt;
  reg  [1<<<1:0] DlyCrcCnt;

  assign IncrementNibCnt = (((StateJam | StateBackOff) | TxStartFrm) & (((StateJam | (((StateFCS | StatePAD) | (StateIPG | StatePreamble)) | |StateData)) | (~ExcessiveDefer & StateDefer)) | StateBackOff)) | (((StateFCS | StatePAD) | (StateIPG | StatePreamble)) | |StateData);
  assign ResetNibCnt = StartIPG | (StartJam | (((StartDefer | StateIdle) | StartFCS) | (((NibCntEq7 & StateJam) | (NibCntEq15 & (StatePreamble | (NibCntEq7 & StateJam)))) | (ExcessiveDefer & (((StatePreamble | StateDefer) & (StatePreamble | (~TxStartFrm & ExcessiveDefer))) & (~TxStartFrm & StateDefer))))));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= 16'h0;
            else if (IncrementNibCnt) NibCnt <= 16'd1+NibCnt;
              
          end
      end
  assign NibCntEq7 = &NibCnt[1<<<1:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= ((-1)+(MinFL+(-16'd4))<<<1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (~ExDfrEn & 14'h17b7);
  assign IncrementByteCnt = (((StateBackOff & &NibCnt[6:0]) | ~ByteCntMax) | ((StateFCS | StatePAD) & (NibCnt[0] & ~ByteCntMax))) & (((StateFCS | StatePAD) & (NibCnt[0] & ~ByteCntMax)) | (StateData[1] | (StateBackOff & &NibCnt[6:0])));
  assign ResetByteCnt = (PacketFinished_q | (StartBackoff | TxStartFrm)) & (StateIdle | (StartBackoff | PacketFinished_q));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= 16'd1+ByteCnt[15:0];
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (MaxFL[15:0] & ~HugEn);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= 3'h0;
        else 
          begin
            if ((StateData[1] & DlyCrcCnt) == (3'h4 | (StartJam | PacketFinished_q))) DlyCrcCnt <= 3'h0;
            else if ((|DlyCrcCnt[1<<<1:0] | (DlyCrcEn & StateSFD)) & ((StateSFD | StateData[1]) & DlyCrcEn)) DlyCrcCnt <= 3'd1+DlyCrcCnt;
              
          end
      end
endmodule

