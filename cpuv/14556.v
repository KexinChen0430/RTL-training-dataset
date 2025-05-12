module \$_DLATCH_NP1_ (E, R, D, Q);
input E;  
input R;  
input D;  
output reg Q; 
always @* begin
	if (R == 1) 
                Q <= 1; 
	else if (E == 0) 
		Q <= D; 
end
endmodule