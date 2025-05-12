
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

  assign StartIdle = ((~MRxDV & StatePreamble) | (|StateData & ~MRxDV)) | (((StateSFD | |StateData) & ~MRxDV) | (~MRxDV & StateDrop));
  assign StartPreamble = (StateIdle & ~Transmitting) & (MRxDV & ~MRxDEq5);
  assign StartSFD = (StatePreamble & (MRxDEq5 & MRxDV)) | (StateIdle & ((StatePreamble & (MRxDEq5 & MRxDV)) | (~Transmitting & (MRxDEq5 & MRxDV))));
  assign StartData0 = (MRxDV & (StateData1 | (MRxDEqD & StateSFD))) & (StateData1 | IFGCounterEq24);
  assign StartData1 = (MRxDV & ~ByteCntMaxFrame) & StateData0;
  assign StartDrop = (((StateData0 | (Transmitting & StateIdle)) & ((Transmitting & StateIdle) | ByteCntMaxFrame)) & MRxDV) | (MRxDV & ((MRxDEqD & StateSFD) & ~IFGCounterEq24));
  
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
            if (StartPreamble | (StartDrop | StartSFD)) StateIdle <= 1'b0;
            else if (StartIdle) StateIdle <= 1'b1;
              
            if (StartIdle) StateDrop <= 1'b0;
            else if (StartDrop) StateDrop <= 1'b1;
              
            if (StartSFD | (StartDrop | StartIdle)) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (StartPreamble | ((StartDrop | StartIdle) | StartData0)) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if ((StartData1 | StartDrop) | StartIdle) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartDrop | StartIdle) | StartData0) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

