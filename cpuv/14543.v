module \$_DFFSRE_NNPN_ (C, S, R, E, D, Q);
input C, S, R, E, D;
output reg Q;
always @(negedge C, negedge S, posedge R) begin
	if (R == 1)
		Q <= 0;
	else if (S == 0)
		Q <= 1;
        else if (E == 0)
		Q <= D;
end
endmodule