module \$_DLATCH_PP0_ (E, R, D, Q);
input E, R, D;
output reg Q;
always @* begin
	if (R == 1)
                Q <= 0;
	else if (E == 1)
		Q <= D;
end
endmodule