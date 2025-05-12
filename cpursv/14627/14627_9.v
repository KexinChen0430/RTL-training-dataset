
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

  assign StartIdle = ((|StateData | (~MRxDV & (StatePreamble | StateDrop))) | (StateSFD & ~MRxDV)) & ~MRxDV;
  assign StartPreamble = (~MRxDEq5 & MRxDV) & (StateIdle & ~Transmitting);
  assign StartSFD = (MRxDV & (MRxDEq5 & StatePreamble)) | ((MRxDEq5 & (StateIdle & ~Transmitting)) & MRxDV);
  assign StartData0 = ((StateSFD & MRxDEqD) & ((StateData1 | IFGCounterEq24) & MRxDV)) | (StateData1 & ((StateData1 | IFGCounterEq24) & MRxDV));
  assign StartData1 = (StateData0 & ~ByteCntMaxFrame) & MRxDV;
  assign StartDrop = (MRxDV & (ByteCntMaxFrame & StateData0)) | (MRxDV & (((MRxDEqD | ((StateIdle | MRxDEqD) & Transmitting)) & (((StateIdle | ~IFGCounterEq24) & (~IFGCounterEq24 | Transmitting)) & StateSFD)) | (Transmitting & StateIdle)));
  
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
            if ((StartDrop | StartSFD) | StartPreamble) StateIdle <= #Tp 1'b0;
            else if (StartIdle) StateIdle <= #Tp 1'b1;
              
            if (StartIdle) StateDrop <= #Tp 1'b0;
            else if (StartDrop) StateDrop <= #Tp 1'b1;
              
            if ((StartDrop | StartIdle) | StartSFD) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartData0 | (StartDrop | StartIdle)) | StartPreamble) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartData1 | StartDrop) | StartIdle) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if (StartData0 | (StartDrop | StartIdle)) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

