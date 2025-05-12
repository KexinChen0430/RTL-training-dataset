module \$_DLATCHSR_NNN_ (E, S, R, D, Q);
input E, S, R, D;
output reg Q;
always @* begin
	if (R == 0)
		Q <= 0;
	else if (S == 0)
		Q <= 1;
	else if (E == 0)
		Q <= D;
end
endmodule