
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

  assign StartIdle = ((~MRxDV & StatePreamble) | (~MRxDV & |StateData)) | (~MRxDV & (StateDrop | StateSFD));
  assign StartPreamble = ((StateIdle & MRxDV) & ~Transmitting) & ~MRxDEq5;
  assign StartSFD = ((StatePreamble & (MRxDV & MRxDEq5)) | ((StateIdle & MRxDV) & ~Transmitting)) & MRxDEq5;
  assign StartData0 = (((MRxDV & StateSFD) & (IFGCounterEq24 & MRxDEqD)) | ((MRxDEqD & StateSFD) & ((StateData1 & MRxDV) | (MRxDV & IFGCounterEq24)))) | (StateData1 & ((StateData1 & MRxDV) | (MRxDV & IFGCounterEq24)));
  assign StartData1 = (StateData0 & ~ByteCntMaxFrame) & MRxDV;
  assign StartDrop = (((StateIdle & Transmitting) & MRxDV) | (MRxDV & (StateData0 & ByteCntMaxFrame))) | ((~IFGCounterEq24 & MRxDEqD) & (MRxDV & StateSFD));
  
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
              
            if ((StartDrop | StartSFD) | StartIdle) StatePreamble <= 1'b0;
            else if (StartPreamble) StatePreamble <= 1'b1;
              
            if (((StartData0 | StartIdle) | StartDrop) | StartPreamble) StateSFD <= 1'b0;
            else if (StartSFD) StateSFD <= 1'b1;
              
            if ((StartIdle | StartData1) | StartDrop) StateData0 <= 1'b0;
            else if (StartData0) StateData0 <= 1'b1;
              
            if ((StartData0 | StartIdle) | StartDrop) StateData1 <= 1'b0;
            else if (StartData1) StateData1 <= 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

