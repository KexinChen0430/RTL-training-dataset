
module GP_DFFSRI(input  D,CLK,nSR,
                 output reg nQ);

  parameter  INIT = 1'bx;
  parameter  SRMODE = 1'bx;

  
  initial    nQ = INIT;
  
  always @(posedge CLK or negedge nSR)
      begin
        if (!nSR) nQ <= ~SRMODE;
        else nQ <= ~D;
      end
endmodule

