
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

  assign StartIdle = (((|StateData & ~MRxDV) | ((~MRxDV & StateSFD) | StatePreamble)) | StateDrop) & ~MRxDV;
  assign StartPreamble = ~Transmitting & ((StateIdle & ~MRxDEq5) & MRxDV);
  assign StartSFD = ((MRxDEq5 & (StateIdle & ~Transmitting)) & MRxDV) | (MRxDV & (MRxDEq5 & StatePreamble));
  assign StartData0 = ((StateData1 & MRxDV) | (StateData1 & MRxDV)) | ((((StateData1 | StateData1) | IFGCounterEq24) & (MRxDEqD & StateSFD)) & MRxDV);
  assign StartData1 = (~ByteCntMaxFrame & MRxDV) & StateData0;
  assign StartDrop = ((MRxDV & (StateData0 & ((((Transmitting | ~IFGCounterEq24) & (Transmitting | (MRxDEqD & StateSFD))) & (((MRxDEqD & ~IFGCounterEq24) | StateIdle) & (StateIdle | StateSFD))) | ((((StateIdle & (((Transmitting | ~IFGCounterEq24) & (~IFGCounterEq24 | StateIdle)) & Transmitting)) | MRxDEqD) & (~IFGCounterEq24 & StateSFD)) | ByteCntMaxFrame)))) | ((((StateIdle & (((Transmitting | ~IFGCounterEq24) & (~IFGCounterEq24 | StateIdle)) & Transmitting)) | MRxDEqD) & MRxDV) & (StateIdle & (((Transmitting | ~IFGCounterEq24) & (~IFGCounterEq24 | StateIdle)) & Transmitting)))) | ((~IFGCounterEq24 & ((StateIdle & (((Transmitting | ~IFGCounterEq24) & (~IFGCounterEq24 | StateIdle)) & Transmitting)) | StateSFD)) & (((StateIdle & (((Transmitting | ~IFGCounterEq24) & (~IFGCounterEq24 | StateIdle)) & Transmitting)) | MRxDEqD) & MRxDV));
  
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
            if (StartSFD | (StartPreamble | StartDrop)) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if (StartSFD | (StartDrop | StartIdle)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (((StartData0 | StartDrop) | StartPreamble) | StartIdle) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if (StartData1 | (StartDrop | StartIdle)) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartIdle | StartData0) | StartDrop) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

