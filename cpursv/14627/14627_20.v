
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

  assign StartIdle = ((StateDrop & ~MRxDV) | (~MRxDV & (StatePreamble | |StateData))) | (~MRxDV & StateSFD);
  assign StartPreamble = MRxDV & (~MRxDEq5 & (~Transmitting & StateIdle));
  assign StartSFD = (((~Transmitting | StatePreamble) & (MRxDEq5 & MRxDV)) & StatePreamble) | (StateIdle & ((~Transmitting | StatePreamble) & (MRxDEq5 & MRxDV)));
  assign StartData0 = ((MRxDV & StateData1) | (IFGCounterEq24 & (MRxDV & StateSFD))) & (MRxDEqD | (MRxDV & StateData1));
  assign StartData1 = (MRxDV & StateData0) & ~ByteCntMaxFrame;
  assign StartDrop = ((StateData0 & (((MRxDV & ByteCntMaxFrame) | (((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV)) & (~IFGCounterEq24 & ((StateIdle & Transmitting) | StateSFD)))) | ((StateIdle & Transmitting) & ((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV))))) | ((((MRxDV & StateData0) | ((StateIdle & Transmitting) & ((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV)))) | (((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV)) & (StateSFD & ~IFGCounterEq24))) & (StateIdle & ((MRxDEqD | Transmitting) & ((StateSFD & ~IFGCounterEq24) | Transmitting))))) | (((~IFGCounterEq24 & MRxDEqD) & (((StateIdle | MRxDEqD) & (StateIdle | (StateSFD & ~IFGCounterEq24))) & StateSFD)) & (((MRxDV & StateData0) | ((StateIdle & Transmitting) & ((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV)))) | (((MRxDEqD | Transmitting) & ((StateIdle | MRxDEqD) & MRxDV)) & (StateSFD & ~IFGCounterEq24))));
  
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
            if ((StartPreamble | StartDrop) | StartSFD) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartData0 | StartPreamble) | (StartIdle | StartDrop)) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartData1) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if ((StartData0 | StartDrop) | StartIdle) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

