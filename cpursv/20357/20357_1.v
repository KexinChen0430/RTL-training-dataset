
module myDFFS(output reg Q,
              input  D,CLK,SET);

  parameter  INIT = 1'b1;

  
  initial    Q = INIT;
  
  always @(posedge CLK)
      begin
        if (SET) Q <= 1'b1;
        else Q <= D;
      end
endmodule

