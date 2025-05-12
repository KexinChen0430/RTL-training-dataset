module bt656cap_colorspace(
	input vid_clk, 
	input stb_i, 
	input field_i, 
	input [31:0] ycc422, 
	output reg stb_o, 
	output reg field_o, 
	output [31:0] rgb565 
);