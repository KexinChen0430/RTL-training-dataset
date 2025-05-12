
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

  assign IncrementNibCnt = ((StateJam | StateBackOff) | (StateFCS | (((|StateData | StatePreamble) | StatePAD) | StateIPG))) | (TxStartFrm & ((StateDefer & ~ExcessiveDefer) | ((StateJam | StateBackOff) | (StateFCS | (((|StateData | StatePreamble) | StatePAD) | StateIPG)))));
  assign ResetNibCnt = StartJam | (StartFCS | ((StartDefer | StartIPG) | (((StateIdle | (((ExcessiveDefer & ((NibCntEq15 & StatePreamble) | StateDefer)) | (NibCntEq15 & StatePreamble)) & (~TxStartFrm | (NibCntEq15 & StatePreamble)))) | NibCntEq7) & (((StateIdle | StateJam) | (((ExcessiveDefer & ((NibCntEq15 & StatePreamble) | StateDefer)) | (NibCntEq15 & StatePreamble)) & (~TxStartFrm | (NibCntEq15 & StatePreamble)))) | (StartDefer | StartIPG)))));
  
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
  assign NibbleMinFl = NibCnt >= ((((-16'd4)+MinFL)*1<<<1)-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (~ExDfrEn & 14'h17b7);
  assign IncrementByteCnt = (((~ByteCntMax | (StateBackOff | (StateData[1] & ~ByteCntMax))) & (~ByteCntMax | ((StateData[1] | &NibCnt[6:0]) & (&NibCnt[6:0] | ~ByteCntMax)))) | ((NibCnt[0] & ~ByteCntMax) & (StateFCS | StatePAD))) & (((NibCnt[0] & ~ByteCntMax) & (StateFCS | StatePAD)) | ((&NibCnt[6:0] & (StateBackOff & ((~ByteCntMax | (StateBackOff | (StateData[1] & ~ByteCntMax))) & (~ByteCntMax | ((StateData[1] | &NibCnt[6:0]) & (&NibCnt[6:0] | ~ByteCntMax)))))) | StateData[1]));
  assign ResetByteCnt = ((PacketFinished_q | StateIdle) | StartBackoff) & ((PacketFinished_q | TxStartFrm) | StartBackoff);
  
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
            if ((DlyCrcCnt & StateData[1]) == ((3'h4 | StartJam) | PacketFinished_q)) DlyCrcCnt <= 3'h0;
            else if ((StateData[1] | (StateSFD & DlyCrcEn)) & ((DlyCrcEn & |DlyCrcCnt[1<<<1:0]) | (StateSFD & DlyCrcEn))) DlyCrcCnt <= 3'd1+DlyCrcCnt;
              
          end
      end
endmodule

