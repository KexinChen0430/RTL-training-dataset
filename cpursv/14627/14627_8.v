
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

  assign StartIdle = ((~MRxDV & (StateDrop | StateSFD)) | (StatePreamble & ~MRxDV)) | (|StateData & ~MRxDV);
  assign StartPreamble = ~MRxDEq5 & ((MRxDV & StateIdle) & ~Transmitting);
  assign StartSFD = ((MRxDV & MRxDEq5) & (StateIdle | StatePreamble)) & (~Transmitting | ((MRxDV & MRxDEq5) & StatePreamble));
  assign StartData0 = ((StateSFD & MRxDEqD) | (StateData1 & MRxDV)) & ((IFGCounterEq24 | StateData1) & MRxDV);
  assign StartData1 = ~ByteCntMaxFrame & (MRxDV & StateData0);
  assign StartDrop = (((MRxDV & (((StateSFD & ~IFGCounterEq24) & (((StateSFD & ~IFGCounterEq24) | Transmitting) & (MRxDEqD | Transmitting))) & MRxDEqD)) | ((MRxDV & StateIdle) & Transmitting)) | ((((ByteCntMaxFrame | StateIdle) & (ByteCntMaxFrame | Transmitting)) | (((StateSFD & ~IFGCounterEq24) & (((StateSFD & ~IFGCounterEq24) | Transmitting) & (MRxDEqD | Transmitting))) & MRxDEqD)) & ((MRxDV & (((StateSFD & ~IFGCounterEq24) & (((StateSFD & ~IFGCounterEq24) | Transmitting) & (MRxDEqD | Transmitting))) & MRxDEqD)) | ((MRxDV & StateIdle) & Transmitting)))) | ((MRxDV & StateData0) & (((ByteCntMaxFrame | StateIdle) & (ByteCntMaxFrame | Transmitting)) | (((StateSFD & ~IFGCounterEq24) & (((StateSFD & ~IFGCounterEq24) | Transmitting) & (MRxDEqD | Transmitting))) & MRxDEqD)));
  
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
            if (StartPreamble | (StartSFD | StartDrop)) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if (StartPreamble | ((StartData0 | StartDrop) | StartIdle)) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartData1) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if ((StartData0 | StartDrop) | StartIdle) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

