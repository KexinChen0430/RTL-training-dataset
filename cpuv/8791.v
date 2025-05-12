module BIBUF (
	input D,
	input E,
	(* iopad_external_pin *)
	inout PAD,
	output Y
);
	assign PAD = E ? D : 1'bz;
	assign Y = PAD;
endmodule