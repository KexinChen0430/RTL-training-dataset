
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
  output [2:0] DlyCrcCnt;
  wire ExcessiveDeferCnt;
  wire ResetNibCnt;
  wire IncrementNibCnt;
  wire ResetByteCnt;
  wire IncrementByteCnt;
  wire ByteCntMax;
  reg  [15:0] NibCnt;
  reg  [15:0] ByteCnt;
  reg  [2:0] DlyCrcCnt;

  assign IncrementNibCnt = (~ExcessiveDefer | (((StateJam | ((StatePreamble | StateIPG) | (StatePAD | |StateData))) | StateBackOff) | StateFCS)) & ((StateDefer & ((((StateFCS | StateJam) | ((StatePreamble | StateIPG) | (StatePAD | |StateData))) | TxStartFrm) | StateBackOff)) | (((StateJam | ((StatePreamble | StateIPG) | (StatePAD | |StateData))) | StateBackOff) | StateFCS));
  assign ResetNibCnt = ((StartIPG | StartDefer) | (StartFCS | StartJam)) | (((((~TxStartFrm & (((~TxStartFrm & StateDefer) | StatePreamble) & (ExcessiveDefer | StatePreamble))) & (ExcessiveDefer & StateDefer)) | (StatePreamble & ((~TxStartFrm | NibCntEq15) & (((StateJam | ((NibCntEq15 & StatePreamble) | ((ExcessiveDefer | (NibCntEq15 & StatePreamble)) & StateDefer))) & (((NibCntEq15 & StatePreamble) | ~TxStartFrm) | StateJam)) & (NibCntEq15 | (ExcessiveDefer & StateDefer)))))) | (StateJam | StateIdle)) & (StateIdle | (((~TxStartFrm & (((~TxStartFrm & StateDefer) | StatePreamble) & (ExcessiveDefer | StatePreamble))) & (ExcessiveDefer & StateDefer)) | (NibCntEq7 | (NibCntEq15 & StatePreamble)))));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= 16'h0;
            else if (IncrementNibCnt) NibCnt <= 16'd1+NibCnt;
              
          end
      end
  assign NibCntEq7 = &NibCnt[2:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= ((((0-16'd4)+MinFL)*2)-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (14'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = ((((StateData[1] & (StateBackOff | (StateData[1] & (StateBackOff | ~ByteCntMax)))) & ~ByteCntMax) | ((StatePAD | StateFCS) & (~ByteCntMax & NibCnt[0]))) | &NibCnt[6:0]) & (((StatePAD | StateFCS) & (~ByteCntMax & NibCnt[0])) | (StateBackOff | (StateData[1] & (StateBackOff | ~ByteCntMax))));
  assign ResetByteCnt = (StartBackoff | PacketFinished_q) | (TxStartFrm & StateIdle);
  
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
            if ((StateData[1] & DlyCrcCnt) == ((StartJam | 3'h4) | PacketFinished_q)) DlyCrcCnt <= 3'h0;
            else if (((DlyCrcEn & StateSFD) | (|DlyCrcCnt[2:0] & DlyCrcEn)) & (StateSFD | StateData[1])) DlyCrcCnt <= DlyCrcCnt+3'd1;
              
          end
      end
endmodule

