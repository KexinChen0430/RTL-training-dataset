module contains the framework for an eighty-state look-up table. 
It takes a seed value followed by an arbitrary list of 79 corner values in
ascending order and uses if-else conditionals, selecting
if(val<val0), state0, if(val<val1), state1, ..., else state_80.
State changes are made on clock edges.
*/
input clk; 
input [13:0] f; 
output reg [6:0] state; 
`include "cornerFreq.v" 
always @(posedge clk) begin 
	if(f<fc[0]) state=7'b1010000; 
	else if(f<fc[1]) state=7'b1001111; 
	else state=7'b0; 
end
endmodule 