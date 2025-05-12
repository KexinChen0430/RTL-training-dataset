
module GP_DLATCH(input  D,
                 input  nCLK,
                 output reg Q);

  parameter  INIT = 1'bx;

  
  initial    Q = INIT;
  
  always @(*)
      begin
        if (!nCLK) Q <= D;
          
      end
endmodule

