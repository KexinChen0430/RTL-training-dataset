module \$_DLATCH_N_ (E, D, Q);
input E, D;
output reg Q;
always @* begin
	if (E == 0)
		Q <= D;
end
endmodule