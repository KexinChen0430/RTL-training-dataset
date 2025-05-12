module \$_DFFE_NP_ (D, C, E, Q);
input D, C, E;
output reg Q;
always @(negedge C) begin
	if (E) Q <= D;
end
endmodule