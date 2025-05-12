module CC_PLL #( 
	parameter REF_CLK = "", 
	parameter OUT_CLK = "", 
	parameter PERF_MD = "", 
	parameter LOW_JITTER = 1, 
	parameter CI_FILTER_CONST = 2, 
	parameter CP_FILTER_CONST = 4 
)(
	input  CLK_REF, 
	input  CLK_FEEDBACK, 
	input  USR_CLK_REF, 
	input  USR_LOCKED_STDY_RST, 
	output USR_PLL_LOCKED_STDY, 
	output USR_PLL_LOCKED, 
	output CLK270, 
	output CLK180, 
	output CLK90, 
	output CLK0, 
	output CLK_REF_OUT 
);
endmodule 