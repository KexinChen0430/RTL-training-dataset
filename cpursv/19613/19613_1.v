
module myDFFNS(output reg Q,
               input  D,CLK,SET);

  parameter  INIT = 1'b1;

  
  initial    Q = INIT;
  
  always @(negedge CLK)
      begin
        if (SET) Q <= 1'b1;
        else Q <= D;
      end
endmodule

