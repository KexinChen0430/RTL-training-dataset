
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

  assign StartIdle = ((~MRxDV & |StateData) | (~MRxDV & StateDrop)) | ((StateSFD | StatePreamble) & ~MRxDV);
  assign StartPreamble = ~MRxDEq5 & ((MRxDV & StateIdle) & ~Transmitting);
  assign StartSFD = MRxDV & ((MRxDEq5 & (StateIdle & ~Transmitting)) | ((StatePreamble & MRxDV) & MRxDEq5));
  assign StartData0 = ((StateSFD & (MRxDV & (IFGCounterEq24 & MRxDEqD))) | StateData1) & MRxDV;
  assign StartData1 = (MRxDV & StateData0) & ~ByteCntMaxFrame;
  assign StartDrop = (((StateIdle & ((Transmitting & StateIdle) | (~IFGCounterEq24 & ((StateSFD | StateIdle) & (StateSFD | Transmitting))))) & MRxDV) & Transmitting) | ((StateData0 & (ByteCntMaxFrame & MRxDV)) | (MRxDV & (((Transmitting & StateIdle) | (~IFGCounterEq24 & ((StateSFD | StateIdle) & (StateSFD | Transmitting)))) & MRxDEqD)));
  
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
            if ((StartDrop | StartPreamble) | StartSFD) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartIdle | StartDrop) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartIdle | (StartData0 | StartDrop)) | StartPreamble) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartData1 | StartDrop) | StartIdle) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if (StartIdle | (StartData0 | StartDrop)) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

