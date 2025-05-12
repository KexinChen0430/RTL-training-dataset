
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

  assign IncrementNibCnt = ((StateJam | StateFCS) | ((~ExcessiveDefer & (StateDefer & TxStartFrm)) | StateBackOff)) | (|StateData | ((StatePreamble | StateIPG) | StatePAD));
  assign ResetNibCnt = ((StartFCS | StartJam) | (StartIPG | ((StartIPG | (StateIdle | (StateJam | ((StateJam | ((StatePreamble & NibCntEq15) | (StateDefer & ExcessiveDefer))) & ((StatePreamble & NibCntEq15) | ~TxStartFrm))))) & ((StateIdle | ((((StateJam | ((StateJam | ((StatePreamble & NibCntEq15) | (StateDefer & ExcessiveDefer))) & ((StatePreamble & NibCntEq15) | ~TxStartFrm))) & (((StateDefer & ExcessiveDefer) | NibCntEq15) & (NibCntEq15 | ~TxStartFrm))) & StatePreamble) | (ExcessiveDefer & (~TxStartFrm & StateDefer)))) | NibCntEq7)))) | StartDefer;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= #Tp 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= #Tp 16'h0;
            else if (IncrementNibCnt) NibCnt <= #Tp NibCnt+1'b1;
              
          end
      end
  assign NibCntEq7 = &NibCnt[1+1:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= (((1+1)*(MinFL+(-3'h4)))+(-1));
  assign ExcessiveDeferCnt = NibCnt[13:0] == 16'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (~ExDfrEn & 16'h17b7);
  assign IncrementByteCnt = (((NibCnt[0] & ~ByteCntMax) & ((StatePAD & NibCnt[0]) | StateFCS)) | (~ByteCntMax & ((((~ByteCntMax | &NibCnt[6:0]) & StateData[1]) | &NibCnt[6:0]) & StateData[1]))) | (&NibCnt[6:0] & (StateBackOff | ((StateBackOff | ~ByteCntMax) & StateData[1])));
  assign ResetByteCnt = (TxStartFrm & StateIdle) | (PacketFinished_q | StartBackoff);
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= #Tp 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= #Tp 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= #Tp ByteCnt[15:0]+1'b1;
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (~HugEn & MaxFL[15:0]);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= #Tp 3'h0;
        else 
          begin
            if ((DlyCrcCnt & StateData[1]) == (PacketFinished_q | (3'h4 | StartJam))) DlyCrcCnt <= #Tp 3'h0;
            else if ((StateSFD | StateData[1]) & ((|DlyCrcCnt[1+1:0] & DlyCrcEn) | (DlyCrcEn & StateSFD))) DlyCrcCnt <= #Tp DlyCrcCnt+1'b1;
              
          end
      end
endmodule

