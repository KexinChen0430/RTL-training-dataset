module wb_to_avalon_bridge #( 
	parameter DW = 32,	
	parameter AW = 32,	
	parameter BURST_SUPPORT = 0 
)(
	input 		  clk, 
	input 		  rst, 
	input [AW-1:0] 	  wbm_adr_i, 
	input [DW-1:0] 	  wbm_dat_i, 
	input [DW/8-1:0]  wbm_sel_i, 
	input 		  wbm_we_i, 
	input 		  wbm_cyc_i, 
	input 		  wbm_stb_i, 
	input [2:0] 	  wbm_cti_i, 
	input [1:0] 	  wbm_bte_i, 
	output [DW-1:0]   wbm_dat_o, 
	output 		  wbm_ack_o, 
	output 		  wbm_err_o, 
	output 		  wbm_rty_o, 
	output [AW-1:0]   avm_address_o, 
	output [DW/8-1:0] avm_byteenable_o, 
	output 		  avm_read_o, 
	input [DW-1:0] 	  avm_readdata_i, 
	output [7:0] 	  avm_burstcount_o, 
	output 		  avm_write_o, 
	output [DW-1:0]   avm_writedata_o, 
	input 		  avm_waitrequest_i, 
	input 		  avm_readdatavalid_i 
);