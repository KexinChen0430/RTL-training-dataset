module altpll2 (
	areset,
	clkswitch,
	inclk0,
	inclk1,
	activeclock,
	c0,
	clkbad0,
	clkbad1,
	locked);
	input	  areset;
	input	  clkswitch;
	input	  inclk0;
	input	  inclk1;
	output	  activeclock;
	output	  c0;
	output	  clkbad0;
	output	  clkbad1;
	output	  locked;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	  areset;
	tri0	  clkswitch;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule