module \$_ALDFFE_PNP_ (D, C, L, AD, E, Q);
input D, C, L, AD, E;
output reg Q;
always @(posedge C or negedge L) begin
	if (L == 0)
		Q <= AD;
	else if (E == 1)
		Q <= D;
end
endmodule