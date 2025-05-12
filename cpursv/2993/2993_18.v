
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

  assign IncrementNibCnt = (((StateBackOff | (((StatePreamble | StateIPG) | (StatePAD | |StateData)) | StateJam)) | StateFCS) | TxStartFrm) & (((StateBackOff | (((StatePreamble | StateIPG) | (StatePAD | |StateData)) | StateJam)) | StateFCS) | (StateDefer & (((StateBackOff | (((StatePreamble | StateIPG) | (StatePAD | |StateData)) | StateJam)) | StateFCS) | ~ExcessiveDefer)));
  assign ResetNibCnt = (StartJam | (StartFCS | StartIPG)) | (((StateJam | (StateIdle | ((StateIdle | ((NibCntEq15 & StatePreamble) | (ExcessiveDefer & (StateDefer | (NibCntEq15 & StatePreamble))))) & ((NibCntEq15 & StatePreamble) | ~TxStartFrm)))) & ((((NibCntEq15 & StatePreamble) | ~TxStartFrm) & ((NibCntEq15 & StatePreamble) | (ExcessiveDefer & (StateDefer | (NibCntEq15 & StatePreamble))))) | (NibCntEq7 | StateIdle))) | StartDefer);
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= #Tp 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= #Tp 16'h0;
            else if (IncrementNibCnt) NibCnt <= #Tp 1'b1+NibCnt;
              
          end
      end
  assign NibCntEq7 = &NibCnt[2:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= ((MinFL-3'h4)<<<1+(-1));
  assign ExcessiveDeferCnt = NibCnt[13:0] == 16'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (16'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = (~ByteCntMax | (&NibCnt[6:0] & StateBackOff)) & (((&NibCnt[6:0] & StateBackOff) | StateData[1]) | ((NibCnt[0] & StateFCS) | (StatePAD & NibCnt[0])));
  assign ResetByteCnt = PacketFinished_q | ((TxStartFrm | StartBackoff) & (PacketFinished_q | (StateIdle | StartBackoff)));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= #Tp 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= #Tp 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= #Tp ByteCnt[15:0]+1'b1;
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (MaxFL[15:0] & ~HugEn);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= #Tp 3'h0;
        else 
          begin
            if ((DlyCrcCnt & StateData[1]) == ((3'h4 | StartJam) | PacketFinished_q)) DlyCrcCnt <= #Tp 3'h0;
            else if ((DlyCrcEn & (StateData[1] & |DlyCrcCnt[2:0])) | (StateSFD & DlyCrcEn)) DlyCrcCnt <= #Tp DlyCrcCnt+1'b1;
              
          end
      end
endmodule

