module \$_SDFF_NN1_ (D, C, R, Q);
input D, C, R;
output reg Q;
always @(negedge C) begin
	if (R == 0)
		Q <= 1;
	else
		Q <= D;
end
endmodule