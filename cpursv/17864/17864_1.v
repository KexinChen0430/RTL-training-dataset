
module DFFN(output reg Q,
            input  CLK,D);

  parameter  INIT = 1'b0;

  
  initial    Q = INIT;
  
  always @(negedge CLK)  Q <= D;
endmodule

