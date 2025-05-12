
module GP_DLATCHSR(input  D,
                   input  nCLK,
                   input  nSR,
                   output reg Q);

  parameter  INIT = 1'bx;
  parameter  SRMODE = 1'bx;

  
  initial    Q = INIT;
  
  always @(*)
      begin
        if (!nSR) Q <= SRMODE;
        else if (!nCLK) Q <= D;
          
      end
endmodule

