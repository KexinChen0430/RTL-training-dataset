
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

  assign IncrementNibCnt = (StateJam | (((StateBackOff | (|StateData | ((StatePAD | StateIPG) | StatePreamble))) | StateFCS) | TxStartFrm)) & ((StatePAD | ((StateFCS | ((StateIPG | |StateData) | StatePreamble)) | StateJam)) | (StateBackOff | (StateDefer & ~ExcessiveDefer)));
  assign ResetNibCnt = ((((StateIdle | (NibCntEq7 & (StateJam | StateIdle))) | StartIPG) | ((NibCntEq15 & StatePreamble) | ((~TxStartFrm & ((~TxStartFrm | StatePreamble) & ((StateDefer & ExcessiveDefer) | StatePreamble))) & (StateDefer & ExcessiveDefer)))) | (StartJam | StartFCS)) | StartDefer;
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= 16'h0;
            else if (IncrementNibCnt) NibCnt <= NibCnt+16'd1;
              
          end
      end
  assign NibCntEq7 = &NibCnt[2:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= (((MinFL+(-16'd4))*2)+(0-1));
  assign ExcessiveDeferCnt = NibCnt[13:0] == 14'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (14'h17b7 & ~ExDfrEn);
  assign IncrementByteCnt = (((((StateData[1] & (StateBackOff | ~ByteCntMax)) | StateBackOff) | ((StatePAD | StateFCS) & NibCnt[0])) & (((StatePAD | StateFCS) & NibCnt[0]) | ((StateData[1] & (&NibCnt[6:0] | ~ByteCntMax)) | &NibCnt[6:0]))) & ~ByteCntMax) | ((((StateData[1] | StateBackOff) & ((((StateData[1] & (StateBackOff | ~ByteCntMax)) | StateBackOff) | ((StatePAD | StateFCS) & NibCnt[0])) & (((StatePAD | StateFCS) & NibCnt[0]) | ((StateData[1] & (&NibCnt[6:0] | ~ByteCntMax)) | &NibCnt[6:0])))) & (StateBackOff | ~ByteCntMax)) & ((StateData[1] & (&NibCnt[6:0] | ~ByteCntMax)) | &NibCnt[6:0]));
  assign ResetByteCnt = StartBackoff | (((StartBackoff | TxStartFrm) | PacketFinished_q) & (PacketFinished_q | StateIdle));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) ByteCnt[15:0] <= 16'h0;
        else 
          begin
            if (ResetByteCnt) ByteCnt[15:0] <= 16'h0;
            else if (IncrementByteCnt) ByteCnt[15:0] <= ByteCnt[15:0]+16'd1;
              
          end
      end
  assign MaxFrame = ByteCnt[15:0] == (MaxFL[15:0] & ~HugEn);
  assign ByteCntMax = &ByteCnt[15:0];
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) DlyCrcCnt <= 3'h0;
        else 
          begin
            if ((StateData[1] & DlyCrcCnt) == (3'h4 | (PacketFinished_q | StartJam))) DlyCrcCnt <= 3'h0;
            else if (((|DlyCrcCnt[2:0] & StateData[1]) | (DlyCrcEn & StateSFD)) & DlyCrcEn) DlyCrcCnt <= 3'd1+DlyCrcCnt;
              
          end
      end
endmodule

