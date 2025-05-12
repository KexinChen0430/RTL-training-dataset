module lineto(
	input clk, 
	input reset, 
	input strobe, 
	input [BITS-1:0] x_in, 
	input [BITS-1:0] y_in, 
	output ready, 
	output axis, 
	output [BITS-1:0] x_out, 
	output [BITS-1:0] y_out 
);
	parameter BITS = 16; 
	reg [BITS-1:0] err; 
	reg [BITS-1:0] x_dst; 
	reg [BITS-1:0] y_dst; 
	reg [BITS-1:0] x_out; 
	reg [BITS-1:0] y_out; 
	assign ready = (x_dst == x_out) && (y_dst == y_out);
	reg axis; 
	reg sx; 
	reg sy; 
	reg signed [BITS-1:0] dx; 
	reg signed [BITS-1:0] dy; 
	wire signed [BITS:0] err2 = err << 1; 
	always @(posedge clk) 
	begin
		if (reset) begin 
			x_dst <= x_in;
			y_dst <= y_in;
			x_out <= x_in;
			y_out <= y_in;
			err <= 0; 
			axis <= 0; 
		end else
		if (strobe) begin 
			x_dst <= x_in; 
			y_dst <= y_in; 
			axis <= 0; 
			if (x_in > x_out) begin 
				sx <= 1; 
				dx <= x_in - x_out; 
			end else begin
				sx <= 0; 
				dx <= x_out - x_in; 
			end
			if (y_in > y_out) begin 
				sy <= 1; 
				dy <= y_in - y_out; 
			end else begin
				sy <= 0; 
				dy <= y_out - y_in; 
			end
			err <= ((x_in > x_out) ? (x_in - x_out) : (x_out - x_in)) 
				((y_in > y_out) ? (y_in - y_out) : (y_out - y_in)); 
		end else
		if (!ready) begin 
			if (err2 > -dy) 
			begin
				err <= err - dy; 
				x_out <= x_out + (sx ? 1 : -1); 
				axis <= 0; 
			end else
			if (err2 < dx) 
			begin
				err <= err + dx; 
				y_out <= y_out + (sy ? 1 : -1); 
				axis <= 1; 
			end
		end
	end
endmodule