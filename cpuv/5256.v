module Expansion( 
     right, 
     ouput 
    );
	 input [32:1] right; 
    output reg [48:1] ouput; 
	 wire [32:1] right; 
	 always @ (right) 
	 begin
	                      ouput[1]<= right[32]; 
								 ouput[2]<= right[1]; 
	 end
endmodule 