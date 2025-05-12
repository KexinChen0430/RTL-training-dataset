module \$_DFFSRE_NPNP_ (C, S, R, E, D, Q); 
input C, S, R, E, D; 
output reg Q; 
always @(negedge C, posedge S, negedge R) begin
	if (R == 0) 
		Q <= 0; 
	else if (S == 1) 
		Q <= 1; 
    else if (E == 1) 
		Q <= D; 
end
endmodule 