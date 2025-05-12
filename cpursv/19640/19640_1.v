
module myDFFP(output reg Q,
              input  D,CLK,PRESET);

  parameter  INIT = 1'b1;

  
  initial    Q = INIT;
  
  always @(posedge CLK or posedge PRESET)
      begin
        if (PRESET) Q <= 1'b1;
        else Q <= D;
      end
endmodule

