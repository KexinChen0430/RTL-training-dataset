module opb2wb(	OPB_Clk, rst,
		opb_abus, opb_be, opb_dbus, opb_rnw, opb_select, opb_seqaddr,
		sl_dbus, sl_errack, sl_retry, sl_toutsup, sl_xferack,
		wb_data_o, wb_data_i, wb_addr_o,
		wb_cyc_o, wb_stb_o, wb_sel_o, wb_we_o, wb_ack_i, wb_err_i, wb_rty_i
	);
parameter	C_BASEADDR	= 32'h8000_0000,
		C_HIGHADDR	= 32'h8000_00ff;
input				OPB_Clk;
input				rst;
input	[31:0]		opb_abus;
input	[3:0]		opb_be;
input	[31:0]		opb_dbus;
input			opb_rnw;
input			opb_select;
input			opb_seqaddr;
output	[31:0]		sl_dbus;
output			sl_errack;
output			sl_retry;
output			sl_toutsup;
output			sl_xferack;
output	[31:0]		wb_data_o;
input	[31:0]		wb_data_i;
output	[31:0]		wb_addr_o;
output			wb_cyc_o, wb_stb_o;
output	[3:0]		wb_sel_o;
output			wb_we_o;
input			wb_ack_i, wb_err_i, wb_rty_i;
endmodule