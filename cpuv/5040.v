module Decoder (
	address,
	bitline,
	enable,
);
parameter	LOG_SIZE=0;
`include "definition/Definition.v"
input	[LOG_SIZE-1:0]	address;
output	reg	[(1<<LOG_SIZE)-1:0]	bitline;
input	enable;
always @(*) begin
	if(!enable) begin	
		bitline	<= 0;
	end 
	else begin		
		bitline	<= (1<<address);
	end
end
endmodule