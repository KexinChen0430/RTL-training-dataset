
module HazardCheckUnit(IDEXMemRead,IDEXRt,IFIDRs,IFIDRt,PCWrite,IFIDWrite,
                       ctrlSetZero,IDEXRd,IDEXRegWrite,opcode,EXMEMRead,EXMEMRt,clk);

  input  [4:0] IDEXRt,IFIDRt,IFIDRs,IDEXRd,EXMEMRt;
  input  IDEXMemRead,IDEXRegWrite,EXMEMRead;
  input  [5:0] opcode;
  input  clk;
  output PCWrite,IFIDWrite,ctrlSetZero;
  reg  PCWrite,IFIDWrite,ctrlSetZero;

  
  initial  
  begin
    PCWrite <= 1;
    IFIDWrite <= 1;
    ctrlSetZero <= 0;
  end
  
  always @(opcode or IDEXMemRead or IDEXRt or IFIDRs or IFIDRt or IDEXRd or IDEXRegWrite or clk)
      begin
        if (opcode == 6'b000100) 
          begin
            if (
((IDEXRt == IFIDRs) || 
(((IDEXRt == IFIDRs) || IDEXMemRead) && 
(IDEXRt == IFIDRt))) && IDEXMemRead) 
              begin
                PCWrite <= 0;
                IFIDWrite <= 0;
                ctrlSetZero <= 1;
              end
            else if (
((IDEXRegWrite && (IDEXRd == IFIDRt)) || 
(IDEXRd == IFIDRs) || (IDEXRd == IFIDRt)) && IDEXRegWrite) 
              begin
                PCWrite <= 0;
                IFIDWrite <= 0;
                ctrlSetZero <= 1;
              end
            else 
              begin
                PCWrite <= 1;
                IFIDWrite <= 1;
                ctrlSetZero <= 0;
              end
            if (EXMEMRead && 
                ((EXMEMRt == IFIDRt) || (EXMEMRt == IFIDRs))) 
              begin
                PCWrite <= 0;
                IFIDWrite <= 0;
                ctrlSetZero <= 1;
              end
              
          end
        else 
          begin
            if (
((IDEXRt == IFIDRs) || 
(((IDEXRt == IFIDRs) || IDEXMemRead) && 
(IDEXRt == IFIDRt))) && IDEXMemRead) 
              begin
                PCWrite <= 0;
                IFIDWrite <= 0;
                ctrlSetZero <= 1;
              end
            else 
              begin
                PCWrite <= 1;
                IFIDWrite <= 1;
                ctrlSetZero <= 0;
              end
          end
      end
endmodule

