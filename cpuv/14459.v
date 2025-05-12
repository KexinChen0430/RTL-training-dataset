module \$_SR_NP_ (S, R, Q);
input S, R;
output reg Q;
always @* begin
	if (R == 1)
		Q <= 0;
	else if (S == 0)
		Q <= 1;
end
endmodule