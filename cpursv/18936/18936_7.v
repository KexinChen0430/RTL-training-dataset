
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

  assign SerialEn = ((((((BitCounter == 0) | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31))) | ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46)) & (((BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)) | ((InProgress & ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46)) & ((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress))) | ((NoPre & ~WriteOp) & InProgress))) & (((InProgress & ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46)) & ((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress)) | NoPre)) & (((((InProgress & ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46)) & ((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress)) | ((InProgress & WriteOp) | ((NoPre & (BitCounter == 0)) & ((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress)))) & (((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress) | ((((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46) & ~WriteOp) | ((~WriteOp & (BitCounter == 0)) & InProgress)))) & ((BitCounter == 0) | ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46)))) | (((WriteOp & ((((BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)) & WriteOp) | ((BitCounter == 0) | ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46))) & (InProgress | ((BitCounter == 0) | ((BitCounter > ((BitCounter & ((((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31) | (BitCounter == 0))) & 31)) < 46))))) & (((BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)) & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress)) | ((((NoPre & (InProgress | WriteOp)) & InProgress) & (BitCounter == 0)) & (((~WriteOp & (InProgress | (BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)))) & InProgress) | (((BitCounter > (((NoPre & 31) | (NoPre & (BitCounter == 0))) | 31)) & WriteOp) | ((~WriteOp & (BitCounter == 0)) & InProgress)))));
  
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
                MdoEn_2d <= (SerialEn | (BitCounter & (InProgress | SerialEn))) < 32;
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
                Mdo_2d <= (~SerialEn & BitCounter) < 32;
                Mdo_d <= Mdo_2d | ShiftedBit;
                Mdo <= Mdo_d;
              end
              
          end
      end
endmodule

