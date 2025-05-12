module dffe (
    output reg Q,       
    input D,            
    (* clkbuf_sink *)   
    input CLK,          
    input EN            
);
  parameter [0:0] INIT = 1'b0;
  initial Q = INIT;
  always @(posedge CLK)
    if (EN)             
      Q <= D;           
endmodule 