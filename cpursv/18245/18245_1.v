
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

  assign IncrementNibCnt = ((TxStartFrm & ~ExcessiveDefer) | (((StatePAD | StateFCS) | (StateBackOff | StateJam)) | (|StateData | (StatePreamble | StateIPG)))) & ((((StatePAD | StateFCS) | (StateBackOff | StateJam)) | (|StateData | (StatePreamble | StateIPG))) | StateDefer);
  assign ResetNibCnt = ((((StateJam & NibCntEq7) | (StateIdle | StartDefer)) | (((StateDefer | StatePreamble) & ((ExcessiveDefer & ~TxStartFrm) | StatePreamble)) & ((StateDefer & ((ExcessiveDefer & ~TxStartFrm) | NibCntEq15)) | NibCntEq15))) | (StartJam | StartFCS)) | StartIPG;
  
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
  assign NibbleMinFl = NibCnt >= ((-1)+(((0-16'd4)+MinFL)*2));
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (14'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = (((~ByteCntMax & (StatePAD | StateFCS)) | ((StateBackOff | (StateData[1] & ~ByteCntMax)) & (&NibCnt[6:0] | (StateData[1] & (~ByteCntMax | &NibCnt[6:0]))))) & NibCnt[0]) | ((StateBackOff | (StateData[1] & ~ByteCntMax)) & (&NibCnt[6:0] | (StateData[1] & (~ByteCntMax | &NibCnt[6:0]))));
  assign ResetByteCnt = ((PacketFinished_q | StateIdle) | StartBackoff) & ((StartBackoff | TxStartFrm) | PacketFinished_q);
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= ByteCnt[15:0]+16'd1;
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (~HugEn & MaxFL[15:0]);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= 3'h0;
        else 
          begin
            if ((DlyCrcCnt & StateData[1]) == ((StartJam | PacketFinished_q) | 3'h4)) DlyCrcCnt <= 3'h0;
            else if ((DlyCrcEn & (|DlyCrcCnt[2:0] & StateData[1])) | (DlyCrcEn & StateSFD)) DlyCrcCnt <= 3'd1+DlyCrcCnt;
              
          end
      end
endmodule

