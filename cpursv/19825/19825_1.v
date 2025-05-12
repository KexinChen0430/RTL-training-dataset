
module GP_DFFSI(input  D,CLK,nSET,
                output reg nQ);

  parameter  INIT = 1'bx;

  
  initial    nQ = INIT;
  
  always @(posedge CLK or negedge nSET)
      begin
        if (!nSET) nQ <= 1'b0;
        else nQ <= ~D;
      end
endmodule

