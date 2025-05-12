
module eth_rxstatem(MRxClk,Reset,MRxDV,ByteCntEq0,ByteCntGreat2,Transmitting,
                    MRxDEq5,MRxDEqD,IFGCounterEq24,ByteCntMaxFrame,StateData,
                    StateIdle,StatePreamble,StateSFD,StateDrop);

  parameter  Tp = 1;
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

  assign StartIdle = (~MRxDV & StateDrop) | (((~MRxDV & StateSFD) | (|StateData & ~MRxDV)) | (StatePreamble & ~MRxDV));
  assign StartPreamble = MRxDV & (StateIdle & (~Transmitting & ~MRxDEq5));
  assign StartSFD = (((~Transmitting & MRxDEq5) & MRxDV) | ((MRxDV & MRxDEq5) & StatePreamble)) & (StatePreamble | StateIdle);
  assign StartData0 = (MRxDV & (StateData1 | (StateSFD & MRxDEqD))) & (IFGCounterEq24 | StateData1);
  assign StartData1 = (StateData0 & ~ByteCntMaxFrame) & MRxDV;
  assign StartDrop = ((((StateData0 | Transmitting) & ((((StateSFD & ~IFGCounterEq24) | (StateIdle & (Transmitting | (StateSFD & ~IFGCounterEq24)))) & StateIdle) | StateData0)) | (~IFGCounterEq24 & ((StateIdle & Transmitting) | (StateSFD & ((StateIdle & (MRxDEqD | Transmitting)) | MRxDEqD))))) | ((MRxDEqD | Transmitting) & (Transmitting | (StateSFD & ~IFGCounterEq24)))) & (((((StateData0 | Transmitting) & ((((StateSFD & ~IFGCounterEq24) | (StateIdle & (Transmitting | (StateSFD & ~IFGCounterEq24)))) & StateIdle) | StateData0)) | (~IFGCounterEq24 & ((StateIdle & Transmitting) | (StateSFD & ((StateIdle & (MRxDEqD | Transmitting)) | MRxDEqD))))) | ((StateIdle | MRxDEqD) & ((StateSFD & ~IFGCounterEq24) | StateIdle))) & (((MRxDV & ByteCntMaxFrame) | (MRxDV & (StateIdle & Transmitting))) | (MRxDV & ((StateSFD & ((StateIdle & (MRxDEqD | Transmitting)) | MRxDEqD)) & ~IFGCounterEq24))));
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) 
          begin
            StateIdle <= #Tp 1'b0;
            StateDrop <= #Tp 1'b1;
            StatePreamble <= #Tp 1'b0;
            StateSFD <= #Tp 1'b0;
            StateData0 <= #Tp 1'b0;
            StateData1 <= #Tp 1'b0;
          end
        else 
          begin
            if (StartDrop | (StartPreamble | StartSFD)) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if (StartSFD | (StartDrop | StartIdle)) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if (((StartDrop | StartData0) | StartIdle) | StartPreamble) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if (StartDrop | (StartData1 | StartIdle)) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

