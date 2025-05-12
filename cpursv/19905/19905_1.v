
module GP_DLATCHSRI(input  D,
                    input  nCLK,
                    input  nSR,
                    output reg nQ);

  parameter  INIT = 1'bx;
  parameter  SRMODE = 1'bx;

  
  initial    nQ = INIT;
  
  always @(*)
      begin
        if (!nSR) nQ <= ~SRMODE;
        else if (!nCLK) nQ <= ~D;
          
      end
endmodule

