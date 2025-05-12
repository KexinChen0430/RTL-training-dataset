module CC_PLL_ADV #(
	parameter [95:0] PLL_CFG_A = 96'bx, 
	parameter [95:0] PLL_CFG_B = 96'bx  
)(
	input  CLK_REF, 
	input  CLK_FEEDBACK, 
	input  USR_CLK_REF, 
	input  USR_LOCKED_STDY_RST, 
	input  USR_SEL_A_B, 
	output USR_PLL_LOCKED_STDY, 
	output USR_PLL_LOCKED, 
	output CLK270, 
	output CLK180, 
	output CLK90, 
	output CLK0, 
	output CLK_REF_OUT 
);
endmodule