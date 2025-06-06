module \$_DFFE_PN1P_ (D, C, R, E, Q); 
input D, C, R, E; 
output reg Q; 
always @(posedge C or negedge R) begin 
	if (R == 0) 
		Q <= 1; 
	else if (E == 1) 
		Q <= D; 
end 
endmodule 