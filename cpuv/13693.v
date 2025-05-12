module VGA_Display(actual_x, actual_y, barra_y, ball_x, ball_y, r_out, g_out, b_out);
	input [9:0] actual_x, ball_x; 
	input [8:0] actual_y, barra_y, ball_y; 
	output reg r_out, g_out, b_out; 
	always @(*) 
		begin
			if( (actual_x < 10'd640) && (actual_y < 10'd480) )
				begin
					if( (actual_x > `X_INICIAL_BARRA) && (actual_x < `X_INICIAL_BARRA + `ANCHO_BARRA) &&
	                (actual_y > barra_y) && (actual_y < (barra_y + `ALTO_BARRA)) ||
						 (actual_x > ball_x) && (actual_x < (ball_x + `ANCHO_BOLA)) &&
						 (actual_y > ball_y) && (actual_y < (ball_y + `ALTO_BOLA))
						)
						begin
							r_out <= 1'b0; 
							g_out <= 1'b0; 
							b_out <= 1'b1; 
						end
					else
						begin
							r_out <= 1'b1; 
							g_out <= 1'b1; 
							b_out <= 1'b1; 
						end
				end
			else 
				begin
					r_out <= 1'b0; 
					g_out <= 1'b0; 
					b_out <= 1'b0; 
				end
		end 
endmodule 