module ewCounter (
    input clk,          
    output [3:0] count  
);
  wire clk;             
  reg[3:0] count;       
  initial
    count = 0;          
  always @ ( negedge clk )
    count[0] <= ~count[0]; 
  always @ ( negedge count[0] )
    count[1] <= ~count[1]; 
  always @ ( negedge count[1] )
    count[2] <= ~count[2]; 
  always @ ( negedge count[2] )
    count[3] <= ~count[3]; 
endmodule 