module four_bit_counter_enable (
	aclr,
	clock,
	cnt_en,
	q);
	input	  aclr;
	input	  clock;
	input	  cnt_en;
	output	[3:0]  q;
endmodule