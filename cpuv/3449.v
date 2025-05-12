module dpram_64_32x32_be (
	data,
	wren,
	wraddress,
	rdaddress,
	byteena_a,
	wrclock,
	rdclock,
	q);
    input	[63:0]  data;
    input	  wren;
    input	[4:0]  wraddress;
    input	[5:0]  rdaddress;
    input	[7:0]  byteena_a;
    input	  wrclock;
    input	  rdclock;
    output	[31:0]  q;
endmodule