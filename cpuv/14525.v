module \$_SDFFCE_NP0P_ (D, C, R, E, Q);
input D; 
input C; 
input R; 
input E; 
output reg Q; 
always @(negedge C) begin
	if (E == 1) begin
		if (R == 1)
			Q <= 0;
		else
			Q <= D;
	end
end
endmodule