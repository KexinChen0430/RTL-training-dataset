
module Stack(CLK,RESET,PUSH,POP,D,Q);

  parameter  WIDTH = 11;
  parameter  DEPTH_POW = 7;
  parameter  DEPTH = 1<<<DEPTH_POW;
  input  CLK;
  input  RESET;
  input  PUSH;
  input  POP;
  input  [WIDTH+(0-1):0] D;
  output reg [WIDTH+(0-1):0] Q;
  reg  [(0-1)+DEPTH_POW:0] PTR;
  reg  [WIDTH+(0-1):0] STACK[0:DEPTH+(0-1)];

  
  always @(posedge CLK)
      if (RESET) PTR <= 0;
      else if (PUSH) PTR <= PTR+1;
      else if (POP) PTR <= PTR+(0-1);
        
  
  always @(posedge CLK)
      if (PUSH || POP) 
        begin
          if (PUSH) 
            begin
              STACK[PTR] <= D;
            end
            
          Q <= STACK[PTR+(0-1)];
        end
        
endmodule

