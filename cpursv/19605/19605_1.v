
module myDFFNSE(output reg Q,
                input  D,CLK,CE,SET);

  parameter  INIT = 1'b1;

  
  initial    Q = INIT;
  
  always @(negedge CLK)
      begin
        if (SET) Q <= 1'b1;
        else if (CE) Q <= D;
          
      end
endmodule

