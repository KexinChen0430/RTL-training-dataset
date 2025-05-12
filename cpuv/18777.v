module dffec (
  output reg Q,       
  input D,            
  (* clkbuf_sink *)   
  input CLK,          
  input EN,           
  (* clkbuf_sink *)   
  input CLR           
);
  parameter [0:0] INIT = 1'b0;
  initial Q = INIT;   
  always @(posedge CLK or posedge CLR)
    if (CLR) Q <= 1'b0;   
    else if (EN) Q <= D;  
endmodule