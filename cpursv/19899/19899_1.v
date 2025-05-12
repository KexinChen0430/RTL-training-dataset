
module GP_DFFRI(input  D,CLK,nRST,
                output reg nQ);

  parameter  INIT = 1'bx;

  
  initial    nQ = INIT;
  
  always @(posedge CLK or negedge nRST)
      begin
        if (!nRST) nQ <= 1'b1;
        else nQ <= ~D;
      end
endmodule

