module CLKBIBUF ( 
	input D, 
	input E, 
	(* iopad_external_pin *) 
	inout PAD, 
	(* clkbuf_driver *) 
	output Y 
);
	assign PAD = E ? D : 1'bz; 
	assign Y = PAD; 
endmodule 