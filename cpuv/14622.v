module yellowCounter 
(
  input clk, 
  output [1:0] count 
);
  wire clk; 
  reg[1:0] count; 
  initial 
    	count = 0; 
  always @ ( negedge clk ) 
    		count[0] <= ~count[0]; 
  always @ ( negedge count[0] ) 
    		count[1] <= ~count[1]; 
endmodule 