module pll_hdmi_reconf (
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
	reset_rom_address,
	rom_data_in,
	write_from_rom,
	write_param,
	busy,
	data_out,
	pll_areset,
	pll_configupdate,
	pll_scanclk,
	pll_scanclkena,
	pll_scandata,
	rom_address_out,
	write_rom_ena);
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
	input	  reset_rom_address;
	input	  rom_data_in;
	input	  write_from_rom;
	input	  write_param;
	output	  busy;
	output	[8:0]  data_out;
	output	  pll_areset;
	output	  pll_configupdate;
	output	  pll_scanclk;
	output	  pll_scanclkena;
	output	  pll_scandata;
	output	[7:0]  rom_address_out;
	output	  write_rom_ena;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	  pll_areset_in;
	tri0	  reset_rom_address;
	tri0	  rom_data_in;
	tri0	  write_from_rom;
`ifndef ALTERA_RESERVED_QIS
`endif
	wire  sub_wire0;
	wire [8:0] sub_wire1;
	wire  sub_wire2;
	wire  sub_wire3;
	wire  sub_wire4;
	wire  sub_wire5;
	wire  sub_wire6;
	wire [7:0] sub_wire7;
	wire  sub_wire8;
	wire  busy = sub_wire0;
	wire [8:0] data_out = sub_wire1[8:0];
	wire  pll_areset = sub_wire2;
	wire  pll_configupdate = sub_wire3;
	wire  pll_scanclk = sub_wire4;
	wire  pll_scanclkena = sub_wire5;
	wire  pll_scandata = sub_wire6;
	wire [7:0] rom_address_out = sub_wire7[7:0];
	wire  write_rom_ena = sub_wire8;
	pll_hdmi_reconf_pllrcfg_hk11	pll_hdmi_reconf_pllrcfg_hk11_component (
				.clock (clock),
				.counter_param (counter_param),
				.counter_type (counter_type),
				.data_in (data_in),
				.pll_areset_in (pll_areset_in),
				.pll_scandataout (pll_scandataout),
				.pll_scandone (pll_scandone),
				.read_param (read_param),
				.reconfig (reconfig),
				.reset (reset),
				.reset_rom_address (reset_rom_address),
				.rom_data_in (rom_data_in),
				.write_from_rom (write_from_rom),
				.write_param (write_param),
				.busy (sub_wire0),
				.data_out (sub_wire1),
				.pll_areset (sub_wire2),
				.pll_configupdate (sub_wire3),
				.pll_scanclk (sub_wire4),
				.pll_scanclkena (sub_wire5),
				.pll_scandata (sub_wire6),
				.rom_address_out (sub_wire7),
				.write_rom_ena (sub_wire8));
endmodule