
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

  assign StartIdle = ~MRxDV & (((~MRxDV & StatePreamble) | (~MRxDV & StateDrop)) | ((StateSFD & ~MRxDV) | |StateData));
  assign StartPreamble = ~MRxDEq5 & (~Transmitting & (StateIdle & MRxDV));
  assign StartSFD = (MRxDEq5 & MRxDV) & (StatePreamble | (MRxDEq5 & (~Transmitting & (StateIdle & MRxDV))));
  assign StartData0 = (IFGCounterEq24 & (((StateData1 | StateSFD) & (MRxDEqD | StateData1)) & MRxDV)) | (MRxDV & StateData1);
  assign StartData1 = (StateData0 & ~ByteCntMaxFrame) & MRxDV;
  assign StartDrop = ((((Transmitting & StateIdle) & (MRxDV & (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting)))) | ((MRxDV & (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting))) & (((StateIdle | ~IFGCounterEq24) & (~IFGCounterEq24 | Transmitting)) & StateSFD))) | (((Transmitting & StateIdle) & (MRxDV & (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting)))) | ((MRxDV & (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting))) & (((StateIdle | ~IFGCounterEq24) & (~IFGCounterEq24 | Transmitting)) & StateSFD)))) | ((((((~IFGCounterEq24 & StateSFD) | StateData0) | Transmitting) & (((StateData0 | Transmitting) & (StateData0 | (StateIdle & (((StateSFD | Transmitting) & (StateIdle | StateSFD)) & ((StateIdle | ~IFGCounterEq24) & (~IFGCounterEq24 | Transmitting)))))) | ((~IFGCounterEq24 & StateSFD) | StateIdle))) & (((StateData0 | ((~IFGCounterEq24 & StateSFD) & (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting)))) | (MRxDEqD | ((MRxDEqD | StateIdle) & Transmitting))) & ByteCntMaxFrame)) & MRxDV);
  
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
            if ((StartDrop | StartSFD) | StartPreamble) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartDrop | StartIdle) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartPreamble | StartData0) | (StartDrop | StartIdle)) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if (StartData1 | (StartDrop | StartIdle)) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if (StartDrop | (StartIdle | StartData0)) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

