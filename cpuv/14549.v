module \$_DLATCH_PN0_ (E, R, D, Q);
input E, R, D;
output reg Q;
always @* begin
	if (R == 0)
                Q <= 0;
	else if (E == 1)
		Q <= D;
end
endmodule