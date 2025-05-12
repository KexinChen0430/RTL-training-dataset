
module GP_DFFS(input  D,CLK,nSET,
               output reg Q);

  parameter  INIT = 1'bx;

  
  initial    Q = INIT;
  
  always @(posedge CLK or negedge nSET)
      begin
        if (!nSET) Q <= 1'b1;
        else Q <= D;
      end
endmodule

