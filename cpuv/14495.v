module \$_DFFE_PP0P_ (D, C, R, E, Q);
input D, C, R, E;
output reg Q;
always @(posedge C or posedge R) begin
	if (R == 1)
		Q <= 0;
	else if (E == 1)
		Q <= D;
end
endmodule