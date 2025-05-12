module altgx_reconfig ( 
	offset_cancellation_reset, 
	reconfig_clk, 
	reconfig_fromgxb, 
	busy, 
	reconfig_togxb); 
input	  offset_cancellation_reset; 
input	  reconfig_clk; 
input	[16:0]  reconfig_fromgxb; 
output	  busy; 
output	[3:0]  reconfig_togxb; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  offset_cancellation_reset; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	wire  sub_wire0; 
	wire [3:0] sub_wire1; 
	wire  busy = sub_wire0; 
	wire [3:0] reconfig_togxb = sub_wire1[3:0]; 
	altgx_reconfig_alt2gxb_reconfig_v3p	altgx_reconfig_alt2gxb_reconfig_v3p_component ( 
				.offset_cancellation_reset (offset_cancellation_reset), 
				.reconfig_clk (reconfig_clk), 
				.reconfig_fromgxb (reconfig_fromgxb), 
				.busy (sub_wire0), 
				.reconfig_togxb (sub_wire1)); 
endmodule 