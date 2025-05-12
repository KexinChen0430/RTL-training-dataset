
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
  output [1+1:0] DlyCrcCnt;
  wire ExcessiveDeferCnt;
  wire ResetNibCnt;
  wire IncrementNibCnt;
  wire ResetByteCnt;
  wire IncrementByteCnt;
  wire ByteCntMax;
  reg  [15:0] NibCnt;
  reg  [15:0] ByteCnt;
  reg  [1+1:0] DlyCrcCnt;

  assign IncrementNibCnt = (((StateBackOff | StateJam) | StateFCS) | ((StateIPG | StatePreamble) | (StatePAD | |StateData))) | ((((((StateBackOff | StateJam) | StateFCS) | ((StateIPG | StatePreamble) | (StatePAD | |StateData))) | StateDefer) & ~ExcessiveDefer) & ((((StateBackOff | StateJam) | StateFCS) | ((StateIPG | StatePreamble) | (StatePAD | |StateData))) | TxStartFrm));
  assign ResetNibCnt = (((StateIdle | StartDefer) | (((StateIdle | StartDefer) | ((((NibCntEq15 & StatePreamble) | ~TxStartFrm) & (((((NibCntEq15 & StatePreamble) | ~TxStartFrm) & (((NibCntEq15 & StatePreamble) | (StateDefer & ExcessiveDefer)) | NibCntEq7)) | NibCntEq7) & ((NibCntEq15 & StatePreamble) | (StateDefer & ExcessiveDefer)))) | StateJam)) & ((((NibCntEq15 & StatePreamble) | ~TxStartFrm) & (((NibCntEq15 & StatePreamble) | (StateDefer & ExcessiveDefer)) | NibCntEq7)) | NibCntEq7))) | (StartFCS | StartJam)) | StartIPG;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= 16'h0;
            else if (IncrementNibCnt) NibCnt <= 16'd1+NibCnt;
              
          end
      end
  assign NibCntEq7 = &NibCnt[1+1:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= ((MinFL+(0-16'd4))<<<1-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (14'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = (&NibCnt[6:0] & StateBackOff) | ((~ByteCntMax & ((StateData[1] | (&NibCnt[6:0] & StateBackOff)) | ((StateFCS | StatePAD) & NibCnt[0]))) & (((StateFCS | StatePAD) & NibCnt[0]) | ((~ByteCntMax | (&NibCnt[6:0] | ((&NibCnt[6:0] | StateData[1]) & ~ByteCntMax))) & (((StateBackOff | StateData[1]) & (~ByteCntMax | StateBackOff)) | ~ByteCntMax))));
  assign ResetByteCnt = ((TxStartFrm | StartBackoff) & ((PacketFinished_q | StartBackoff) | StateIdle)) | PacketFinished_q;
  
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
            if ((DlyCrcCnt & StateData[1]) == ((PacketFinished_q | 3'h4) | StartJam)) DlyCrcCnt <= 3'h0;
            else if ((StateData[1] | (StateSFD & (DlyCrcEn & (StateData[1] | StateSFD)))) & ((|DlyCrcCnt[1+1:0] | StateSFD) & DlyCrcEn)) DlyCrcCnt <= 3'd1+DlyCrcCnt;
              
          end
      end
endmodule

