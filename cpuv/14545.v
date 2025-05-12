module \$_DFFE_PP0N_ (D, C, R, E, Q);
input D, C, R, E;
output reg Q;
always @(posedge C or posedge R) begin
	if (R == 1)
		Q <= 0;
	else if (E == 0)
		Q <= D;
end
endmodule