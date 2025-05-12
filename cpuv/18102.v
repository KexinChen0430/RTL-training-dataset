module \$_ALDFFE_PNN_ (D, C, L, AD, E, Q);
input D, C, L, AD, E;
output reg Q;
always @(posedge C or negedge L) begin
	if (L == 0)
		Q <= AD;
	else if (E == 0)
		Q <= D;
end
endmodule