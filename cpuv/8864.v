module CLKINT_PRESERVE (
	input A,
	(* clkbuf_driver *)
	output Y
);
	assign Y = A;
endmodule