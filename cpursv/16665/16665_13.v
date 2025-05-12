
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

  assign StartIdle = (((StateDrop & ~MRxDV) | (StatePreamble & ~MRxDV)) | (StateSFD & ~MRxDV)) | (~MRxDV & |StateData);
  assign StartPreamble = (~Transmitting & (StateIdle & MRxDV)) & ~MRxDEq5;
  assign StartSFD = MRxDEq5 & (MRxDV & (StatePreamble | (((MRxDV & MRxDEq5) & (~Transmitting & (StateIdle & MRxDV))) & MRxDEq5)));
  assign StartData0 = ((StateData1 & MRxDV) | (StateData1 & ((StateData1 | MRxDEqD) & ((StateData1 | StateSFD) & MRxDV)))) | (IFGCounterEq24 & ((StateData1 | MRxDEqD) & ((StateData1 | StateSFD) & MRxDV)));
  assign StartData1 = MRxDV & (~ByteCntMaxFrame & StateData0);
  assign StartDrop = ((MRxDV & (StateData0 & ByteCntMaxFrame)) | ((StateIdle | (StateData0 & ByteCntMaxFrame)) & (MRxDV & (Transmitting | (StateData0 & ByteCntMaxFrame))))) | (MRxDEqD & (((StateSFD | ((StateSFD & ~IFGCounterEq24) & (Transmitting & StateIdle))) | (Transmitting & StateIdle)) & (MRxDV & ((~IFGCounterEq24 | ((StateSFD & ~IFGCounterEq24) & (Transmitting & StateIdle))) | (Transmitting & StateIdle)))));
  
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
            if (StartSFD | (StartDrop | StartPreamble)) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if (StartSFD | (StartDrop | StartIdle)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if ((StartDrop | StartIdle) | (StartData0 | StartPreamble)) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if (StartData1 | (StartDrop | StartIdle)) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartDrop | StartData0) | StartIdle) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

