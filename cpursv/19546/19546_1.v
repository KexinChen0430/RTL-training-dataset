
module myDFF(output reg Q,
             input  CLK,D);

  parameter  INIT = 1'b0;

  
  initial    Q = INIT;
  
  always @(posedge CLK)  Q <= D;
endmodule

