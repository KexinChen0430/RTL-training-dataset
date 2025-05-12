
module eth_outputcontrol(Clk,Reset,InProgress,ShiftedBit,BitCounter,WriteOp,NoPre,
                         MdcEn_n,Mdo,MdoEn);

  parameter  Tp = 1;
  input  Clk;
  input  Reset;
  input  WriteOp;
  input  NoPre;
  input  InProgress;
  input  ShiftedBit;
  input  [6:0] BitCounter;
  input  MdcEn_n;
  output Mdo;
  output MdoEn;
  wire SerialEn;
  reg  MdoEn_2d;
  reg  MdoEn_d;
  reg  MdoEn;
  reg  Mdo_2d;
  reg  Mdo_d;
  reg  Mdo;

  assign SerialEn = ((((InProgress & ~WriteOp) | ((((BitCounter == 0) & ((InProgress & ~WriteOp) | (((BitCounter > (BitCounter & 31)) < 46) & ~WriteOp))) & InProgress) | ((BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))) & ((InProgress & ~WriteOp) | (WriteOp & InProgress))))) & ((((InProgress & ~WriteOp) | (BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0)))))) & ((BitCounter == 0) | ((((BitCounter > (BitCounter & 31)) < 46) | (((BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))) & ((InProgress & ~WriteOp) | (BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))))) & ((InProgress & ~WriteOp) | (WriteOp & InProgress)))) & (((BitCounter > (BitCounter & 31)) < 46) | WriteOp)))) & ((((BitCounter > (BitCounter & 31)) < 46) | (((BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))) & ((InProgress & ~WriteOp) | (BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))))) & ((InProgress & ~WriteOp) | (WriteOp & InProgress)))) & (((BitCounter > (BitCounter & 31)) < 46) | WriteOp)))) & ((InProgress & ~WriteOp) | (WriteOp & InProgress))) | ((((InProgress & ~WriteOp) | ((((BitCounter == 0) & ((InProgress & ~WriteOp) | (((BitCounter > (BitCounter & 31)) < 46) & ~WriteOp))) & InProgress) | ((BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))) & ((InProgress & ~WriteOp) | (WriteOp & InProgress))))) & ((BitCounter > (31 | ((31 & NoPre) | (NoPre & (BitCounter == 0))))) | (NoPre & (BitCounter == 0)))) & ((NoPre & (BitCounter == 0)) | (WriteOp & InProgress)));
  
  always @(posedge Clk or posedge Reset)
      begin
        if (Reset) 
          begin
            MdoEn_2d <= 1'b0;
            MdoEn_d <= 1'b0;
            MdoEn <= 1'b0;
          end
        else 
          begin
            if (MdcEn_n) 
              begin
                MdoEn_2d <= (SerialEn | ((InProgress & SerialEn) | (((SerialEn | BitCounter) & (InProgress | WriteOp)) & InProgress))) < 32;
                MdoEn_d <= MdoEn_2d;
                MdoEn <= MdoEn_d;
              end
              
          end
      end
  
  always @(posedge Clk or posedge Reset)
      begin
        if (Reset) 
          begin
            Mdo_2d <= 1'b0;
            Mdo_d <= 1'b0;
            Mdo <= 1'b0;
          end
        else 
          begin
            if (MdcEn_n) 
              begin
                Mdo_2d <= (BitCounter & ~SerialEn) < 32;
                Mdo_d <= Mdo_2d | ShiftedBit;
                Mdo <= Mdo_d;
              end
              
          end
      end
endmodule

