module CoarseDelay (
	address,
	clock,
	q);
    input	[2:0]  address;
    input	  clock;
    output	[63:0]  q;
endmodule