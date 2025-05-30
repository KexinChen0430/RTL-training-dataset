module \$_DFF_PN0_ (D, C, R, Q);
input D; 
input C; 
input R; 
output reg Q; 
always @(posedge C or negedge R) begin
	if (R == 0) 
		Q <= 0; 
	else
		Q <= D; 
end
endmodule 