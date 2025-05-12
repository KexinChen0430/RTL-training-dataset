module dffpc (
  output reg Q,       
  input D,            
  (* clkbuf_sink *)   
  input CLK,          
  (* clkbuf_sink *)   
  input CLR,          
  (* clkbuf_sink *)   
  input PRE           
);
  parameter [0:0] INIT = 1'b0; 
  initial Q = INIT;            
  always @(posedge CLK or posedge CLR or posedge PRE)
    if (CLR) Q <= 1'b0;        
    else if (PRE) Q <= 1'b1;   
    else Q <= D;               
endmodule