module \$_SDFFE_NN0P_ (D, C, R, E, Q);
input D, C, R, E;
output reg Q;
always @(negedge C) begin
	if (R == 0)
		Q <= 0;
	else if (E == 1)
		Q <= D;
end
endmodule