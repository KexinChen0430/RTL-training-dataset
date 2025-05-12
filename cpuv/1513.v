module graphics(
	clk, 
	candraw, 
	x, y, 
	p1_y, p2_y, 
	ball_on, 
	ball_x, ball_y, 
	red, green, blue, 
	vga_blank 
	);
input clk;
input candraw;
input ball_on;
input [10:0] x, y, p1_y, p2_y, ball_x, ball_y;
output reg [9:0] red, green, blue;
output vga_blank;
reg n_vga_blank;
assign vga_blank = !n_vga_blank;
always @(posedge clk) begin
	if (candraw) begin
		n_vga_blank <= 1'b0;
		if (x < `batwidth && y > p1_y && y < p1_y + `batheight) begin
			red <= 10'b1111111111;
			green <= 10'b1111111111;
			blue <= 10'b1111111111;
		end
		else if (x > `hc - `batwidth && y > p2_y && y < p2_y + `batheight) begin
			red <= 10'b1111111111;
			green <= 10'b1111111111;
			blue <= 10'b1111111111;
		end
		else if (ball_on && x > ball_x && x < ball_x + `ballsize && y > ball_y && y < ball_y + `ballsize) begin
			red <= 10'b1111111111;
			green <= 10'b1111111111;
			blue <= 10'b1111111111;
		end
		else begin
			red <= 10'b0000000000;
			green <= 10'b0000000000;
			blue <= 10'b0000000000;
		end
	end else begin
		n_vga_blank <= 1'b1;
	end
end
endmodule