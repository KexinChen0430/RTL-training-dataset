module bidir_switch_block(
	input [wire_width*wire_width*12-1:0] select, 
	inout [wire_width-1:0] left,                 
	inout [wire_width-1:0] right,                
	inout [wire_width-1:0] bottom                
);
parameter wire_width = 3; 
wire [wire_width-1:0] top; 
genvar x, y; 
wire lr[wire_width:0][wire_width:0]; 
wire tb[wire_width:0][wire_width:0]; 
generate
	for(y = 0; y < wire_width; y = y + 1) begin
		for (x = 0; x < wire_width; x = x + 1) begin
			localparam s_base = (x*12)+(y*wire_width*12); 
			if (x == 0) begin
				if (y == 0) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end
			else if (x == wire_width-1) begin
				if (y == 0) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end else begin
				if (y == 0) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin 
					bidir_switch bs(
						.select(select[s_base+11:s_base]),
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end
		end
	end
endgenerate
endmodule