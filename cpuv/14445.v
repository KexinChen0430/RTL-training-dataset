module \$_FF_ (D, Q);
input D;
output reg Q;
always @($global_clock) begin
	Q <= D;
end
endmodule