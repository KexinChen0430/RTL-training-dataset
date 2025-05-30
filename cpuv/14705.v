module fscmos # 
(
	parameter integer C_IN_WIDTH	= 8, 
	parameter integer C_OUT_WIDTH	= 8 
)
(
	input wire		cmos_pclk, 
	input wire		cmos_vsync, 
	input wire		cmos_href, 
	input wire [C_IN_WIDTH-1:0]	cmos_data, 
	output wire		vid_active_video, 
	output wire[C_OUT_WIDTH-1:0]	vid_data, 
	output wire		vid_hblank, 
	output wire		vid_hsync, 
	output wire		vid_vblank, 
	output wire		vid_vsync 
);
	assign vid_active_video= (cmos_href && ~cmos_vsync); 
	assign vid_hblank = ~cmos_href; 
	assign vid_hsync = vid_hblank; 
	assign vid_vsync = vid_vblank; 
	assign vid_vblank = ~cmos_vsync; 
generate 
if (C_IN_WIDTH < C_OUT_WIDTH) begin: in_lt_out 
	assign vid_data = {cmos_data, {(C_OUT_WIDTH - C_IN_WIDTH){1'b0}}}; 
end
else begin: in_ge_out 
	assign vid_data = cmos_data[C_IN_WIDTH-1:C_IN_WIDTH-C_OUT_WIDTH]; 
end
endgenerate 
endmodule 