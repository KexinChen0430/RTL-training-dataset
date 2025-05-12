
module GP_DFF(input  D,CLK,
              output reg Q);

  parameter  INIT = 1'bx;

  
  initial    Q = INIT;
  
  always @(posedge CLK)  begin
    Q <= D;
  end
endmodule

