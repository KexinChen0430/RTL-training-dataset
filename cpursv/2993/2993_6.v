
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
  output [1<<1:0] DlyCrcCnt;
  wire ExcessiveDeferCnt;
  wire ResetNibCnt;
  wire IncrementNibCnt;
  wire ResetByteCnt;
  wire IncrementByteCnt;
  wire ByteCntMax;
  reg  [15:0] NibCnt;
  reg  [15:0] ByteCnt;
  reg  [1<<1:0] DlyCrcCnt;

  assign IncrementNibCnt = (~ExcessiveDefer | ((StateJam | StateBackOff) | (StatePAD | (((StatePreamble | StateIPG) | StateFCS) | |StateData)))) & ((StateDefer & TxStartFrm) | ((StateJam | StateBackOff) | (StatePAD | (((StatePreamble | StateIPG) | StateFCS) | |StateData))));
  assign ResetNibCnt = ((StartFCS | StartJam) | (StartIPG | StartDefer)) | ((StateIdle | (NibCntEq7 & StateJam)) | ((NibCntEq15 & StatePreamble) | (ExcessiveDefer & ((~TxStartFrm & (StatePreamble | (~TxStartFrm & ((ExcessiveDefer & StateDefer) | StatePreamble)))) & StateDefer))));
  
  always @(posedge MTxClk or posedge Reset)
      begin
        if (Reset) NibCnt <= #Tp 16'h0;
        else 
          begin
            if (ResetNibCnt) NibCnt <= #Tp 16'h0;
            else if (IncrementNibCnt) NibCnt <= #Tp NibCnt+1'b1;
              
          end
      end
  assign NibCntEq7 = &NibCnt[1<<1:0];
  assign NibCntEq15 = &NibCnt[3:0];
  assign NibbleMinFl = NibCnt >= ((1<<1*(MinFL-3'h4))-1);
  assign ExcessiveDeferCnt = NibCnt[13:0] == 16'h17b7;
  assign ExcessiveDefer = NibCnt[13:0] == (~ExDfrEn & 16'h17b7);
  assign IncrementByteCnt = (((StatePAD | (NibCnt[0] & StateFCS)) & NibCnt[0]) | (((StateData[1] | StateBackOff) & ~ByteCntMax) | StateBackOff)) & ((((StatePAD | (NibCnt[0] & StateFCS)) & NibCnt[0]) | ((~ByteCntMax | &NibCnt[6:0]) & (StateData[1] | &NibCnt[6:0]))) & ((((~ByteCntMax | &NibCnt[6:0]) & (StateData[1] | &NibCnt[6:0])) & ((((StateData[1] | StateBackOff) & ~ByteCntMax) | StateBackOff) | ~ByteCntMax)) | ~ByteCntMax));
  assign ResetByteCnt = (StateIdle & TxStartFrm) | (StartBackoff | PacketFinished_q);
  
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
            if ((DlyCrcCnt & StateData[1]) == (3'h4 | (StartJam | PacketFinished_q))) DlyCrcCnt <= #Tp 3'h0;
            else if (DlyCrcEn & (((|DlyCrcCnt[1<<1:0] & DlyCrcEn) & StateData[1]) | StateSFD)) DlyCrcCnt <= #Tp 1'b1+DlyCrcCnt;
              
          end
      end
endmodule

