
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

  assign IncrementNibCnt = ((StateBackOff | StateJam) | (|StateData | ((StatePAD | StateFCS) | (StateIPG | StatePreamble)))) | (((TxStartFrm & StateDefer) | ((StateBackOff | StateJam) | (|StateData | ((StatePAD | StateFCS) | (StateIPG | StatePreamble))))) & ~ExcessiveDefer);
  assign ResetNibCnt = ((StartIPG | ((StateIdle | (StateJam & NibCntEq7)) | ((NibCntEq15 & StatePreamble) | (~TxStartFrm & ((((NibCntEq15 | ((~TxStartFrm | NibCntEq15) & (StateDefer & ExcessiveDefer))) & (StateJam | (((StateDefer & ExcessiveDefer) | StatePreamble) & (~TxStartFrm | StatePreamble)))) | StateJam) & ((ExcessiveDefer | (NibCntEq15 & StatePreamble)) & ((NibCntEq15 & StatePreamble) | StateDefer))))))) | (StartFCS | StartJam)) | StartDefer;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= #Tp 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= #Tp 16'h0;
            else if (IncrementNibCnt) NibCnt <= #Tp NibCnt+1'b1;
              
          end
      end
  assign NibCntEq7 = &NibCnt[2:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= (((0-3'h4)+MinFL)<<<1-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 16'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (~ExDfrEn & 16'h17b7);
  assign IncrementByteCnt = ((StateData[1] | (NibCnt[0] & ((StatePAD | StateFCS) & ~ByteCntMax))) & ~ByteCntMax) | (&NibCnt[6:0] & (((~ByteCntMax | (&NibCnt[6:0] | (~ByteCntMax & (&NibCnt[6:0] | StateData[1])))) & (~ByteCntMax | (StateBackOff | ((StateData[1] | StateBackOff) & ~ByteCntMax)))) & StateBackOff));
  assign ResetByteCnt = ((StateIdle | StartBackoff) | PacketFinished_q) & ((StartBackoff | TxStartFrm) | PacketFinished_q);
  
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
            if ((DlyCrcCnt & StateData[1]) == ((StartJam | 3'h4) | PacketFinished_q)) DlyCrcCnt <= #Tp 3'h0;
            else if ((DlyCrcEn & (StateSFD | StateData[1])) & (|DlyCrcCnt[2:0] | (StateSFD & DlyCrcEn))) DlyCrcCnt <= #Tp DlyCrcCnt+1'b1;
              
          end
      end
endmodule

