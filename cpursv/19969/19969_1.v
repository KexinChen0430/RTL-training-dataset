
module myDFFNC(output reg Q,
               input  D,CLK,CLEAR);

  parameter  INIT = 1'b0;

  
  initial    Q = INIT;
  
  always @(negedge CLK or posedge CLEAR)
      begin
        if (CLEAR) Q <= 1'b0;
        else Q <= D;
      end
endmodule

