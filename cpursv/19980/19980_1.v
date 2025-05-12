
module GP_DFFSR(input  D,CLK,nSR,
                output reg Q);

  parameter  INIT = 1'bx;
  parameter  SRMODE = 1'bx;

  
  initial    Q = INIT;
  
  always @(posedge CLK or negedge nSR)
      begin
        if (!nSR) Q <= SRMODE;
        else Q <= D;
      end
endmodule

