module syncfifo_512x32 (
	clock,
	data,
	rdreq,
	sclr,
	wrreq,
	empty,
	full,
	q);
	input	  clock;
	input	[31:0]  data;
	input	  rdreq;
	input	  sclr;
	input	  wrreq;
	output	  empty;
	output	  full;
	output	[31:0]  q;
endmodule