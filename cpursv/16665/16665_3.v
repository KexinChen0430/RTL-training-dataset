
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

  assign StartIdle = ((~MRxDV & (StateSFD | (~MRxDV & |StateData))) | (StatePreamble & ~MRxDV)) | (~MRxDV & StateDrop);
  assign StartPreamble = ~MRxDEq5 & (MRxDV & (StateIdle & ~Transmitting));
  assign StartSFD = ((MRxDV & StatePreamble) & MRxDEq5) | (StateIdle & ((MRxDV & MRxDEq5) & (~Transmitting | StatePreamble)));
  assign StartData0 = (IFGCounterEq24 | StateData1) & ((StateSFD | StateData1) & ((StateData1 | MRxDEqD) & MRxDV));
  assign StartData1 = StateData0 & (MRxDV & ~ByteCntMaxFrame);
  assign StartDrop = ((((((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle) | StateData0) | (((MRxDEqD | (StateIdle & (Transmitting | MRxDEqD))) & ((~IFGCounterEq24 | ((~IFGCounterEq24 & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & ((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle))) | ((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle))) & StateSFD)) & (ByteCntMaxFrame & MRxDV)) | ((((MRxDV & StateData0) | (Transmitting & (StateIdle & MRxDV))) | ((((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle) | (StateSFD & ~IFGCounterEq24)) & (MRxDEqD & MRxDV))) & ((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle))) | (((Transmitting | (StateSFD & ~IFGCounterEq24)) & (((StateSFD & ~IFGCounterEq24) | StateIdle) & MRxDEqD)) & (((MRxDV & StateData0) | (Transmitting & (StateIdle & MRxDV))) | ((((((StateSFD | StateIdle) & (StateSFD | Transmitting)) & Transmitting) & StateIdle) | (StateSFD & ~IFGCounterEq24)) & (MRxDEqD & MRxDV))));
  
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
            if (StartDrop | (StartSFD | StartPreamble)) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if ((StartDrop | StartIdle) | StartSFD) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if ((StartDrop | StartIdle) | (StartPreamble | StartData0)) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if (StartData1 | (StartDrop | StartIdle)) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartData0 | StartDrop) | StartIdle) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

