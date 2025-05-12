
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

  assign StartIdle = ((StateDrop & ~MRxDV) | (~MRxDV & |StateData)) | ((StateSFD | (|StateData | StatePreamble)) & ~MRxDV);
  assign StartPreamble = MRxDV & ((~MRxDEq5 & StateIdle) & ~Transmitting);
  assign StartSFD = (((MRxDV & StatePreamble) & MRxDEq5) | ((StateIdle & MRxDV) & ~Transmitting)) & MRxDEq5;
  assign StartData0 = ((MRxDV & StateData1) | (IFGCounterEq24 & (StateSFD & MRxDV))) & ((MRxDV & StateData1) | MRxDEqD);
  assign StartData1 = ~ByteCntMaxFrame & (StateData0 & MRxDV);
  assign StartDrop = ((StateData0 & (MRxDV & (((Transmitting & StateIdle) | ByteCntMaxFrame) | ((StateSFD & (~IFGCounterEq24 | (Transmitting & StateIdle))) & ((Transmitting & (MRxDEqD | StateIdle)) | MRxDEqD))))) | ((MRxDV & (StateSFD & ~IFGCounterEq24)) & MRxDEqD)) | ((Transmitting & StateIdle) & MRxDV);
  
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
              
            if (StartDrop | (StartIdle | StartSFD)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (StartPreamble | ((StartDrop | StartData0) | StartIdle)) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if ((StartDrop | StartData1) | StartIdle) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

