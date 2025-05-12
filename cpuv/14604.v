module \$_DLATCHSR_NPP_ (E, S, R, D, Q);
input E; 
input S; 
input R; 
input D; 
output reg Q; 
always @* begin
	if (R == 1) 
		Q <= 0; 
	else if (S == 1) 
		Q <= 1; 
	else if (E == 0) 
		Q <= D; 
end
endmodule