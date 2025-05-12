module spll_pll (
	areset,
	inclk0,
	pllena,
	c0,
	c1,
	locked);
	input	  areset;
	input	  inclk0;
	input	  pllena;
	output	  c0;
	output	  c1;
	output	  locked;
endmodule