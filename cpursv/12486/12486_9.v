
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
            if ((MEMWBregisterRd == rs) && (MEMWBregisterRd != 0) && 
                !((EXMEMregisterRd != 0) && (EXMEMregisterRd == rs) && 
EXMEMregWrite) && MEMWBregWrite) forwardA <= 2'b01;
            else if ((EXMEMregisterRd != 0) && (EXMEMregisterRd == rs) && 
                     EXMEMregWrite) forwardA <= 2'b10;
            else forwardA <= 0;
            if ((MEMWBregisterRd == rt) && 
                ((MEMWBregisterRd != 0) && MEMWBregWrite && 
!((EXMEMregisterRd != 0) && 
((EXMEMregisterRd == rt) && EXMEMregWrite)))) forwardB <= 2'b01;
            else if ((EXMEMregisterRd != 0) && 
                     ((EXMEMregisterRd == rt) && EXMEMregWrite)) forwardB <= 2'b10;
            else forwardB <= 0;
          end
      end
endmodule

