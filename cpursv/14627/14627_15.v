
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

  assign StartIdle = ((|StateData & ~MRxDV) | ((StatePreamble | StateSFD) & ~MRxDV)) | (~MRxDV & StateDrop);
  assign StartPreamble = MRxDV & (StateIdle & (~MRxDEq5 & ~Transmitting));
  assign StartSFD = ((MRxDEq5 & (StatePreamble & MRxDV)) | (MRxDEq5 & (StatePreamble & MRxDV))) | ((((StatePreamble | StatePreamble) | StateIdle) & ~Transmitting) & (MRxDV & MRxDEq5));
  assign StartData0 = (((StateSFD | StateData1) & MRxDEqD) | StateData1) & ((MRxDV & IFGCounterEq24) | (MRxDV & StateData1));
  assign StartData1 = (~ByteCntMaxFrame & StateData0) & MRxDV;
  assign StartDrop = (((ByteCntMaxFrame & StateData0) & MRxDV) | (((((Transmitting | ~IFGCounterEq24) & (Transmitting | (MRxDEqD & StateSFD))) & (~IFGCounterEq24 & MRxDEqD)) & StateSFD) & (((StateData0 & MRxDV) | (((~IFGCounterEq24 & (MRxDV & (MRxDEqD & StateSFD))) | ((StateIdle & Transmitting) & (((StateIdle & Transmitting) | StateSFD) & ~IFGCounterEq24))) | (StateIdle & Transmitting))) & MRxDV))) | ((StateIdle & Transmitting) & (((StateData0 & MRxDV) | (((~IFGCounterEq24 & (MRxDV & (MRxDEqD & StateSFD))) | ((StateIdle & Transmitting) & (((StateIdle & Transmitting) | StateSFD) & ~IFGCounterEq24))) | (StateIdle & Transmitting))) & MRxDV));
  
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
              
            if ((StartDrop | StartIdle) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if (StartDrop | ((StartData0 | StartPreamble) | StartIdle)) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartIdle | StartData1) | StartDrop) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

