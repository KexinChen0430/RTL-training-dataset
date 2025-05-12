module SVGA_TIMING_GENERATION
(
pixel_clock,
reset,
h_synch,
v_synch,
blank,
pixel_count,
line_count
);
input 			pixel_clock;		
input 			reset;				
output 			h_synch;				
output 			v_synch;				
output			blank;				
output [10:0]	pixel_count;		
output [9:0]	line_count;			
reg [9:0]		line_count;			
reg [10:0]		pixel_count;		
reg				h_synch;				
reg				v_synch;				
reg				h_blank;				
reg				v_blank;				
reg				blank;				
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		pixel_count <= 11'h000;
	else if (pixel_count == (`H_TOTAL - 1))
		pixel_count <= 11'h000;
	else
		pixel_count <= pixel_count +1;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		h_synch <= 1'b0;
	else if (pixel_count == (`H_ACTIVE + `H_FRONT_PORCH -1))
		h_synch <= 1'b1;
	else if (pixel_count == (`H_TOTAL - `H_BACK_PORCH -1))
		h_synch <= 1'b0;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		line_count <= 10'h000;
	else if ((line_count == (`V_TOTAL - 1)) && (pixel_count == (`H_TOTAL - 1)))
		line_count <= 10'h000;
	else if ((pixel_count == (`H_TOTAL - 1)))
		line_count <= line_count + 1;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		v_synch = 1'b0;
	else if ((line_count == (`V_ACTIVE + `V_FRONT_PORCH -1) &&
		   (pixel_count == `H_TOTAL - 1)))
		v_synch = 1'b1;
	else if ((line_count == (`V_TOTAL - `V_BACK_PORCH - 1))	&&
		   (pixel_count == (`H_TOTAL - 1)))
		v_synch = 1'b0;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		h_blank <= 1'b0;
	else if (pixel_count == (`H_ACTIVE - 2))
		h_blank <= 1'b1;
	else if (pixel_count == (`H_TOTAL - 2))
		h_blank <= 1'b0;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		v_blank <= 1'b0;
	else if ((line_count == (`V_ACTIVE - 1) &&
		   (pixel_count == `H_TOTAL - 2)))
		v_blank <= 1'b1;
	else if ((line_count == (`V_TOTAL - 1)) &&
		   (pixel_count == (`H_TOTAL - 2)))
		v_blank <= 1'b0;
end
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		blank <= 1'b0;
	else if (h_blank || v_blank)
		blank <= 1'b1;
	else
		blank <= 1'b0;
end
endmodule