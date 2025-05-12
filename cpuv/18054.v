module \$_ALDFFE_NNP_ (D, C, L, AD, E, Q);
input D;  
input C;  
input L;  
input AD; 
input E;  
output reg Q; 
always @(negedge C or negedge L) begin
	if (L == 0) 
		Q <= AD; 
	else if (E == 1) 
		Q <= D; 
end
endmodule 