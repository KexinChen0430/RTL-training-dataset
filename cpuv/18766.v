module dffp (
  output reg Q,       
  input D,            
  (* clkbuf_sink *)   
  input CLK,          
  (* clkbuf_sink *)   
  input PRE           
);
  parameter [0:0] INIT = 1'b0; 
  initial Q = INIT;            
  always @(posedge CLK or posedge PRE)
    if (PRE) Q <= 1'b1;        
    else Q <= D;               
endmodule 