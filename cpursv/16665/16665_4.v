
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

  assign StartIdle = (~MRxDV & (((~MRxDV & StateSFD) | StateDrop) | StatePreamble)) | (|StateData & ~MRxDV);
  assign StartPreamble = ((StateIdle & MRxDV) & ~Transmitting) & ~MRxDEq5;
  assign StartSFD = (StatePreamble & ((MRxDEq5 & MRxDV) & (StateIdle | StatePreamble))) | (~Transmitting & ((MRxDEq5 & MRxDV) & (StateIdle | StatePreamble)));
  assign StartData0 = (((MRxDEqD | StateData1) & StateSFD) | StateData1) & (((StateData1 | StateData1) | IFGCounterEq24) & MRxDV);
  assign StartData1 = (MRxDV & StateData0) & ~ByteCntMaxFrame;
  assign StartDrop = ((((StateIdle & Transmitting) | (~IFGCounterEq24 & (StateSFD | (StateIdle & Transmitting)))) & ((MRxDV & (MRxDEqD | Transmitting)) & (MRxDEqD | StateIdle))) | (((StateIdle & Transmitting) | (~IFGCounterEq24 & (StateSFD | (StateIdle & Transmitting)))) & ((MRxDV & (MRxDEqD | Transmitting)) & (MRxDEqD | StateIdle)))) | (StateData0 & (ByteCntMaxFrame & MRxDV));
  
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
            if ((StartPreamble | StartSFD) | StartDrop) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if ((StartSFD | StartIdle) | StartDrop) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if ((StartIdle | (StartPreamble | StartDrop)) | StartData0) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if (StartIdle | (StartData1 | StartDrop)) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

