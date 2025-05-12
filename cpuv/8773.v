module GCLKINT (
	input A, EN,
	(* clkbuf_driver *)
	output Y
);
	assign Y = A & EN;
endmodule