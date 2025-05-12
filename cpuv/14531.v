module \$_SDFF_PP1_ (D, C, R, Q);
input D, C, R;
output reg Q;
always @(posedge C) begin
	if (R == 1)
		Q <= 1;
	else
		Q <= D;
end
endmodule