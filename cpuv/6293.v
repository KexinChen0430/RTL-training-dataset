module pll_cfg ( 
	clock, 
	counter_param, 
	counter_type, 
	data_in, 
	pll_areset_in, 
	pll_scandataout, 
	pll_scandone, 
	read_param, 
	reconfig, 
	reset, 
	write_param, 
	busy, 
	data_out, 
	pll_areset, 
	pll_configupdate, 
	pll_scanclk, 
	pll_scanclkena, 
	pll_scandata); 
input	  clock; 
input	[2:0]  counter_param; 
input	[3:0]  counter_type; 
input	[8:0]  data_in; 
input	  pll_areset_in; 
input	  pll_scandataout; 
input	  pll_scandone; 
input	  read_param; 
input	  reconfig; 
input	  reset; 
input	  write_param; 
output	  busy; 
output	[8:0]  data_out; 
output	  pll_areset; 
output	  pll_configupdate; 
output	  pll_scanclk; 
output	  pll_scanclkena; 
output	  pll_scandata; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  pll_areset_in; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	wire  sub_wire0; 
	wire [8:0] sub_wire1; 
	wire  sub_wire2; 
	wire  sub_wire3; 
	wire  sub_wire4; 
	wire  sub_wire5; 
	wire  sub_wire6; 
	wire  pll_configupdate = sub_wire0; 
	wire [8:0] data_out = sub_wire1[8:0]; 
	wire  pll_scanclk = sub_wire2; 
	wire  pll_scanclkena = sub_wire3; 
	wire  pll_scandata = sub_wire4; 
	wire  busy = sub_wire5; 
	wire  pll_areset = sub_wire6; 
	pll_cfg_pllrcfg_9mu	pll_cfg_pllrcfg_9mu_component ( 
				.counter_param (counter_param), 
				.data_in (data_in), 
				.counter_type (counter_type), 
				.pll_areset_in (pll_areset_in), 
				.reconfig (reconfig), 
				.pll_scandataout (pll_scandataout), 
				.pll_scandone (pll_scandone), 
				.reset (reset), 
				.write_param (write_param), 
				.clock (clock), 
				.read_param (read_param), 
				.pll_configupdate (sub_wire0), 
				.data_out (sub_wire1), 
				.pll_scanclk (sub_wire2), 
				.pll_scanclkena (sub_wire3), 
				.pll_scandata (sub_wire4), 
				.busy (sub_wire5), 
				.pll_areset (sub_wire6)); 
endmodule 