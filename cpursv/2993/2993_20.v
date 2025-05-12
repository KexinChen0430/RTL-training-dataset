
module eth_txcounters(StatePreamble,StateIPG,StateData,StatePAD,StateFCS,StateJam,
                      StateBackOff,StateDefer,StateIdle,StartDefer,StartIPG,
                      StartFCS,StartJam,StartBackoff,TxStartFrm,MTxClk,Reset,MinFL,
                      MaxFL,HugEn,ExDfrEn,PacketFinished_q,DlyCrcEn,StateSFD,
                      ByteCnt,NibCnt,ExcessiveDefer,NibCntEq7,NibCntEq15,MaxFrame,
                      NibbleMinFl,DlyCrcCnt);

  parameter  Tp = 1;
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

  assign IncrementNibCnt = (((StateBackOff | StateJam) | StateFCS) | (StatePreamble | ((|StateData | StateIPG) | StatePAD))) | (~ExcessiveDefer & (((TxStartFrm | StateBackOff) | ((StatePreamble | ((|StateData | StateIPG) | StatePAD)) | (StateFCS | StateJam))) & StateDefer));
  assign ResetNibCnt = ((StartFCS | (((((StatePreamble & NibCntEq15) | (StateJam & NibCntEq7)) | ~TxStartFrm) & ((StateDefer & ExcessiveDefer) | ((StatePreamble & NibCntEq15) | (StateJam & NibCntEq7)))) | (StateIdle | StartDefer))) | StartJam) | StartIPG;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= #Tp 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= #Tp 16'h0;
            else if (IncrementNibCnt) NibCnt <= #Tp 1'b1+NibCnt;
              
          end
      end
  assign NibCntEq7 = &NibCnt[1<<<1:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= (((MinFL-3'h4)*1<<<1)-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 16'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (16'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = ((((StateData[1] | &NibCnt[6:0]) & (&NibCnt[6:0] | ~ByteCntMax)) & StateBackOff) | (StateData[1] & (((StateData[1] | &NibCnt[6:0]) & (&NibCnt[6:0] | ~ByteCntMax)) & ~ByteCntMax))) | (((StateFCS & NibCnt[0]) | (NibCnt[0] & StatePAD)) & ~ByteCntMax);
  assign ResetByteCnt = ((PacketFinished_q | TxStartFrm) & (PacketFinished_q | StateIdle)) | StartBackoff;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= #Tp 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= #Tp 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= #Tp 1'b1+ByteCnt[15:0];
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (MaxFL[15:0] & ~HugEn);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= #Tp 3'h0;
        else 
          begin
            if ((StateData[1] & DlyCrcCnt) == (PacketFinished_q | (StartJam | 3'h4))) DlyCrcCnt <= #Tp 3'h0;
            else if (((|DlyCrcCnt[1<<<1:0] & DlyCrcEn) | (StateSFD & DlyCrcEn)) & ((StateSFD & DlyCrcEn) | StateData[1])) DlyCrcCnt <= #Tp 1'b1+DlyCrcCnt;
              
          end
      end
endmodule

