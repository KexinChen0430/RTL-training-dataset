
module eth_rxstatem(MRxClk,Reset,MRxDV,ByteCntEq0,ByteCntGreat2,Transmitting,
                    MRxDEq5,MRxDEqD,IFGCounterEq24,ByteCntMaxFrame,StateData,
                    StateIdle,StatePreamble,StateSFD,StateDrop);

  input  MRxClk;
  input  Reset;
  input  MRxDV;
  input  ByteCntEq0;
  input  ByteCntGreat2;
  input  MRxDEq5;
  input  Transmitting;
  input  MRxDEqD;
  input  IFGCounterEq24;
  input  ByteCntMaxFrame;
  output [1:0] StateData;
  output StateIdle;
  output StateDrop;
  output StatePreamble;
  output StateSFD;
  reg  StateData0;
  reg  StateData1;
  reg  StateIdle;
  reg  StateDrop;
  reg  StatePreamble;
  reg  StateSFD;
  wire StartIdle;
  wire StartDrop;
  wire StartData0;
  wire StartData1;
  wire StartPreamble;
  wire StartSFD;

  assign StartIdle = ((~MRxDV & StateDrop) | (|StateData & ~MRxDV)) | ((|StateData & ~MRxDV) | ((StateSFD | StatePreamble) & ~MRxDV));
  assign StartPreamble = ~MRxDEq5 & (~Transmitting & (StateIdle & MRxDV));
  assign StartSFD = MRxDEq5 & (((~Transmitting & StateIdle) & (MRxDEq5 & MRxDV)) | (StatePreamble & MRxDV));
  assign StartData0 = (MRxDV & StateData1) | (((IFGCounterEq24 | StateData1) & (StateSFD & MRxDEqD)) & MRxDV);
  assign StartData1 = StateData0 & (~ByteCntMaxFrame & MRxDV);
  assign StartDrop = ((((ByteCntMaxFrame & StateData0) | Transmitting) & ((ByteCntMaxFrame & StateData0) | StateIdle)) | ((Transmitting | MRxDEqD) & (StateIdle | MRxDEqD))) & (((((((MRxDV & MRxDEqD) & ((StateSFD & (~IFGCounterEq24 | (Transmitting & StateIdle))) | (Transmitting & StateIdle))) | (MRxDV & ((StateIdle | StateData0) & (Transmitting | StateData0)))) & ((Transmitting | (MRxDEqD & (StateSFD & ~IFGCounterEq24))) & StateIdle)) | ((MRxDEqD & (StateSFD & ~IFGCounterEq24)) & (((MRxDV & MRxDEqD) & ((StateSFD & (~IFGCounterEq24 | (Transmitting & StateIdle))) | (Transmitting & StateIdle))) | (MRxDV & ((StateIdle | StateData0) & (Transmitting | StateData0)))))) | (MRxDV & (StateSFD & ~IFGCounterEq24))) | (StateData0 & (ByteCntMaxFrame & MRxDV)));
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) 
          begin
            StateIdle <= 1'b0;
            StateDrop <= 1'b1;
            StatePreamble <= 1'b0;
            StateSFD <= 1'b0;
            StateData0 <= 1'b0;
            StateData1 <= 1'b0;
          end
        else 
          begin
            if ((StartSFD | StartDrop) | StartPreamble) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if (StartDrop | (StartSFD | StartIdle)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if ((StartPreamble | (StartData0 | StartIdle)) | StartDrop) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if (StartData1 | (StartIdle | StartDrop)) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartIdle | StartDrop) | StartData0) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

