module \$_DFFSR_NNP_ (C, S, R, D, Q);
input C, S, R, D;
output reg Q;
always @(negedge C, negedge S, posedge R) begin
	if (R == 1)
		Q <= 0;
	else if (S == 0)
		Q <= 1;
	else
		Q <= D;
end
endmodule