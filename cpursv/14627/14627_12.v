
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

  assign StartIdle = ((|StateData | StateSFD) & ~MRxDV) | (~MRxDV & ((~MRxDV & StateDrop) | StatePreamble));
  assign StartPreamble = ~MRxDEq5 & (MRxDV & (StateIdle & ~Transmitting));
  assign StartSFD = ((MRxDV & MRxDEq5) & (StateIdle & (~Transmitting | StatePreamble))) | ((MRxDEq5 & StatePreamble) & MRxDV);
  assign StartData0 = ((((StateSFD & MRxDEqD) | StateData1) & MRxDV) & StateData1) | (IFGCounterEq24 & (((StateSFD & MRxDEqD) | StateData1) & MRxDV));
  assign StartData1 = ~ByteCntMaxFrame & (MRxDV & StateData0);
  assign StartDrop = (((StateSFD & (~IFGCounterEq24 & MRxDEqD)) | (StateIdle & Transmitting)) | ((ByteCntMaxFrame & MRxDV) & StateData0)) & MRxDV;
  
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
              
            if (StartSFD | (StartIdle | StartDrop)) StatePreamble <= #Tp 1'b0;
            else if (StartPreamble) StatePreamble <= #Tp 1'b1;
              
            if ((StartDrop | StartPreamble) | (StartData0 | StartIdle)) StateSFD <= #Tp 1'b0;
            else if (StartSFD) StateSFD <= #Tp 1'b1;
              
            if ((StartDrop | StartData1) | StartIdle) StateData0 <= #Tp 1'b0;
            else if (StartData0) StateData0 <= #Tp 1'b1;
              
            if (StartDrop | (StartData0 | StartIdle)) StateData1 <= #Tp 1'b0;
            else if (StartData1) StateData1 <= #Tp 1'b1;
              
          end
      end
  assign StateData[1:0] = {StateData1,StateData0};
endmodule

