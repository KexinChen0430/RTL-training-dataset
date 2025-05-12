
module myDFFNRE(output reg Q,
                input  D,CLK,CE,RESET);

  parameter  INIT = 1'b0;

  
  initial    Q = INIT;
  
  always @(negedge CLK)
      begin
        if (RESET) Q <= 1'b0;
        else if (CE) Q <= D;
          
      end
endmodule

