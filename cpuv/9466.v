module altpcie_reconfig_3cgx ( 
	offset_cancellation_reset, 
	reconfig_clk, 
	reconfig_fromgxb, 
	busy, 
	reconfig_togxb); 
	input	  offset_cancellation_reset; 
	input	  reconfig_clk; 
	input	[4:0]  reconfig_fromgxb; 
	output	  busy; 
	output	[3:0]  reconfig_togxb; 
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	  offset_cancellation_reset; 
`ifndef ALTERA_RESERVED_QIS
`endif
	wire [3:0] sub_wire0; 
	wire  sub_wire1; 
	wire [3:0] reconfig_togxb = sub_wire0[3:0]; 
	wire  busy = sub_wire1; 
	altpcie_reconfig_3cgx_alt_c3gxb_reconfig_ffp	altpcie_reconfig_3cgx_alt_c3gxb_reconfig_ffp_component ( 
				.reconfig_clk (reconfig_clk), 
				.offset_cancellation_reset (offset_cancellation_reset), 
				.reconfig_fromgxb (reconfig_fromgxb), 
				.reconfig_togxb (sub_wire0), 
				.busy (sub_wire1)); 
endmodule 