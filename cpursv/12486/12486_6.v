
module SwapUnit(rs,rt,rd,EXMEMregWrite,EXMEMregisterRd,MEMWBregisterRd,
                MEMWBregWrite,forwardA,forwardB,rst);

  input  [4:0] rs,rt,rd,EXMEMregisterRd,MEMWBregisterRd;
  input  EXMEMregWrite,MEMWBregWrite;
  output [1:0] forwardB,forwardA;
  reg  [1:0] forwardA,forwardB;
  input  rst;

  
  always @(rs or rt or rd or EXMEMregWrite or EXMEMregisterRd or MEMWBregisterRd or MEMWBregWrite or forwardA or forwardB or rst)
      begin
        if (rst) 
          begin
            forwardA <= 0;
            forwardB <= 0;
          end
        else 
          begin
            if ((MEMWBregisterRd == rs) && 
                (MEMWBregWrite && (MEMWBregisterRd != 0) && 
!(EXMEMregWrite && (EXMEMregisterRd == rs) && 
(EXMEMregisterRd != 0)))) forwardA <= 2'b01;
            else if (EXMEMregWrite && (EXMEMregisterRd == rs) && 
                     (EXMEMregisterRd != 0)) forwardA <= 2'b10;
            else forwardA <= 0;
            if ((MEMWBregisterRd != 0) && 
                (MEMWBregWrite && 
!((EXMEMregisterRd == rt) && (EXMEMregisterRd != 0) && 
EXMEMregWrite)) && (MEMWBregisterRd == rt)) forwardB <= 2'b01;
            else if ((EXMEMregisterRd == rt) && (EXMEMregisterRd != 0) && 
                     EXMEMregWrite) forwardB <= 2'b10;
            else forwardB <= 0;
          end
      end
endmodule

