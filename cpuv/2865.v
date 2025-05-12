module linebuffer(
	input CK, 
	input WE, 
	input LOAD, 
	input CLEARING, 
	input [3:0] COLOR_INDEX, 
	input PCK2, 
	input [7:0] SPR_PAL, 
	input [7:0] ADDR_LOAD, 
	output [11:0] DATA_OUT 
);