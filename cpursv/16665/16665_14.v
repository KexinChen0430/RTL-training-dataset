
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

  assign StartIdle = ((|StateData | StateSFD) & ~MRxDV) | (~MRxDV & ((StatePreamble | StateDrop) | (|StateData & ~MRxDV)));
  assign StartPreamble = (~MRxDEq5 & (~Transmitting & MRxDV)) & StateIdle;
  assign StartSFD = ((MRxDEq5 & MRxDV) & StatePreamble) | (MRxDEq5 & (StateIdle & (~Transmitting & MRxDV)));
  assign StartData0 = ((StateData1 | StateSFD) & (MRxDEqD | StateData1)) & ((IFGCounterEq24 & MRxDV) | (StateData1 & MRxDV));
  assign StartData1 = (StateData0 & ~ByteCntMaxFrame) & MRxDV;
  assign StartDrop = ((((((StateSFD | ByteCntMaxFrame) & (ByteCntMaxFrame | (~IFGCounterEq24 & MRxDEqD))) & (((~IFGCounterEq24 & StateSFD) | StateData0) & (MRxDEqD | StateData0))) & MRxDV) | ((((~IFGCounterEq24 | StateIdle) & (~IFGCounterEq24 | Transmitting)) & StateSFD) & (Transmitting & (StateIdle & ((~IFGCounterEq24 | StateIdle) & (~IFGCounterEq24 | Transmitting)))))) | (Transmitting & (StateIdle & ((~IFGCounterEq24 | StateIdle) & (~IFGCounterEq24 | Transmitting))))) & MRxDV;
  
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
            if ((StartSFD | StartDrop) | StartPreamble) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if (StartDrop | (StartIdle | StartSFD)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (StartIdle | (StartDrop | (StartPreamble | StartData0))) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if ((StartData1 | StartIdle) | StartDrop) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if (StartData0 | (StartIdle | StartDrop)) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

