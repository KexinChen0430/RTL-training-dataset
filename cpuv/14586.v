module \$_SDFFCE_NN1N_ (D, C, R, E, Q); 
input D, C, R, E; 
output reg Q; 
always @(negedge C) begin 
	if (E == 0) begin 
		if (R == 0) 
			Q <= 1; 
		else
			Q <= D; 
	end
end
endmodule 