
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

  assign StartIdle = ~MRxDV & (((~MRxDV & |StateData) | StatePreamble) | (StateSFD | StateDrop));
  assign StartPreamble = StateIdle & (~Transmitting & (~MRxDEq5 & MRxDV));
  assign StartSFD = ((MRxDV & (MRxDEq5 & StatePreamble)) | StateIdle) & ((~Transmitting | (MRxDV & (MRxDEq5 & StatePreamble))) & (MRxDEq5 & MRxDV));
  assign StartData0 = (MRxDV & StateData1) | ((IFGCounterEq24 & (MRxDV & MRxDEqD)) & StateSFD);
  assign StartData1 = (MRxDV & StateData0) & ~ByteCntMaxFrame;
  assign StartDrop = ((MRxDV & ((((StateData0 | ((MRxDEqD & ~IFGCounterEq24) & (((MRxDEqD | Transmitting) & ((StateSFD & ~IFGCounterEq24) | Transmitting)) & StateSFD))) | ((StateIdle | (StateSFD & ~IFGCounterEq24)) & (StateIdle | MRxDEqD))) & ByteCntMaxFrame) & ((StateData0 | ((MRxDEqD & ~IFGCounterEq24) & (((MRxDEqD | Transmitting) & ((StateSFD & ~IFGCounterEq24) | Transmitting)) & StateSFD))) | ((MRxDEqD | Transmitting) & ((StateSFD & ~IFGCounterEq24) | Transmitting))))) | ((Transmitting & MRxDV) & StateIdle)) | (MRxDV & ((((StateSFD | (((((MRxDEqD | Transmitting) & StateIdle) | MRxDEqD) & StateIdle) & Transmitting)) & ~IFGCounterEq24) & MRxDEqD) | ((((((MRxDEqD | Transmitting) & StateIdle) | MRxDEqD) & StateIdle) & Transmitting) & MRxDEqD)));
  
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
            if (StartSFD | (StartDrop | StartPreamble)) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartIdle | StartSFD) | StartDrop) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartDrop | (StartPreamble | StartIdle)) | StartData0) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if (StartData1 | (StartIdle | StartDrop)) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartData0) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

