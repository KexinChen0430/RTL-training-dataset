
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

  assign StartIdle = (((((StatePreamble | StateDrop) & ~MRxDV) | StateSFD) & ~MRxDV) | ((StatePreamble | StateDrop) & ~MRxDV)) | (~MRxDV & (|StateData | StateSFD));
  assign StartPreamble = ~MRxDEq5 & ((StateIdle & ~Transmitting) & MRxDV);
  assign StartSFD = ((((StateIdle & ~Transmitting) & MRxDEq5) & MRxDV) | StatePreamble) & (MRxDV & MRxDEq5);
  assign StartData0 = ((StateSFD & (MRxDEqD & (IFGCounterEq24 & MRxDV))) | (StateSFD & (MRxDEqD & (IFGCounterEq24 & MRxDV)))) | (StateData1 & MRxDV);
  assign StartData1 = (MRxDV & StateData0) & ~ByteCntMaxFrame;
  assign StartDrop = ((((ByteCntMaxFrame | (((StateIdle & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & Transmitting) & (((Transmitting | ~IFGCounterEq24) & (StateIdle | ~IFGCounterEq24)) & StateSFD))) | ((StateIdle & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & Transmitting)) | (((Transmitting | ~IFGCounterEq24) & (StateIdle | ~IFGCounterEq24)) & StateSFD)) & (((MRxDV & StateData0) | ((((((StateIdle & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & Transmitting) | (~IFGCounterEq24 & StateSFD)) & Transmitting) & MRxDV) & StateIdle)) | (((~IFGCounterEq24 & StateSFD) & MRxDEqD) & MRxDV))) & (((ByteCntMaxFrame | (((StateIdle & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & Transmitting) & (((Transmitting | ~IFGCounterEq24) & (StateIdle | ~IFGCounterEq24)) & StateSFD))) | ((StateIdle & ((StateSFD | StateIdle) & (StateSFD | Transmitting))) & Transmitting)) | MRxDEqD);
  
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
            if ((StartDrop | StartSFD) | StartPreamble) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if ((StartIdle | StartDrop) | StartSFD) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (((StartDrop | StartData0) | StartIdle) | StartPreamble) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if ((StartIdle | StartDrop) | StartData1) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

