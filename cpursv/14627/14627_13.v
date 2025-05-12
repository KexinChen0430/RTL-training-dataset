
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

  assign StartIdle = ((~MRxDV & StateSFD) | (|StateData | ((StateDrop | (StatePreamble & ~MRxDV)) & ~MRxDV))) & ~MRxDV;
  assign StartPreamble = StateIdle & ((~MRxDEq5 & ~Transmitting) & MRxDV);
  assign StartSFD = (((StateIdle & ((MRxDV & MRxDEq5) & ~Transmitting)) | StatePreamble) & MRxDV) & MRxDEq5;
  assign StartData0 = (((MRxDEqD & MRxDV) | (StateData1 & MRxDV)) & (StateSFD | (StateData1 & MRxDV))) & (IFGCounterEq24 | StateData1);
  assign StartData1 = ~ByteCntMaxFrame & (MRxDV & StateData0);
  assign StartDrop = ((((ByteCntMaxFrame & (MRxDEqD & ((((StateSFD | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting))))) & ~IFGCounterEq24) | ((StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))) & (StateSFD & ((~IFGCounterEq24 | ((StateSFD & ~IFGCounterEq24) & (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))))) | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))))))) | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting))))))) | ((StateData0 | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting))))) & ByteCntMaxFrame)) & MRxDV) | (StateIdle & (MRxDV & (Transmitting & ((((StateSFD | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting))))) & ~IFGCounterEq24) | ((StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))) & (StateSFD & ((~IFGCounterEq24 | ((StateSFD & ~IFGCounterEq24) & (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))))) | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting)))))))) | (StateIdle & (Transmitting & ((MRxDEqD | StateIdle) & (MRxDEqD | Transmitting))))))))) | ((StateSFD & (MRxDEqD & ~IFGCounterEq24)) & MRxDV);
  
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
            if (StartSFD | (StartPreamble | StartDrop)) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartData0 | (StartPreamble | StartDrop)) | StartIdle) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if (StartDrop | (StartData1 | StartIdle)) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if (StartData0 | (StartIdle | StartDrop)) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

