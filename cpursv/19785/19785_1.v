
module GP_DFFR(input  D,CLK,nRST,
               output reg Q);

  parameter  INIT = 1'bx;

  
  initial    Q = INIT;
  
  always @(posedge CLK or negedge nRST)
      begin
        if (!nRST) Q <= 1'b0;
        else Q <= D;
      end
endmodule

