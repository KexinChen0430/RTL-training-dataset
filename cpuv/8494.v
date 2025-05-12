module fsm_bola(clk,start_bola, bussy_bola, perdio, bola_x, bola_y, speed, barra_y);
	input clk, start_bola;
	input [4:0] speed;
	output bussy_bola, perdio;
	output [10:0] bola_x;
	output [9:0] bola_y, barra_y;
	reg comenzar;
	reg [2:0] state, direccion_x, direccion_y;;
	parameter STATE_0 = 0;
	parameter STATE_1 = 1;
	parameter STATE_2 = 2;
	parameter STATE_3 = 3;
	initial
		begin
			comenzar <= 0;
			perdio <= 0;
		end
	always@(posedge clk)
	begin
	case(state)
			STATE_0:
			begin
				if (start_bola)
					begin
						comenzar <= 1;
						state <= STATE_1;
					end
			end
			STATE_1:
			begin
				bola_x <= bola_x + direccion_x*speed;
				bola_y <= bola_y + direccion_y*speed;
				state <= STATE_2;
			end
			STATE_2:
			begin
				if (bola_x >= 623)
					begin
						bola_x <= 623;
						direccion_x <= direccion_x*-1;
					end
				if (bola_y >= 463)
					begin
						bola_y <= 463;
						direccion_y <= direccion_y*-1;
					end
				if (bola_y < 0)
					begin
						bola_y <= 0;
						direccion_y <= direccion_y*-1;
					end
				state <= STATE_3;
			end
			STATE_3:
			begin
				if (bola_x <= 23)
					begin
						if ((bola_y >= barra_y) && (bola_y <= barra_y +50))
						begin
						 bola_x <= 32;
						 direccion_x <= direccion_x*-1;
						end
					end
				else
					begin
						perdio <= 1;
					end
			end
		endcase
	end
	assign bussy_bola = ((state == STATE_0)||(state == STATE_1)||(state == STATE_2))&&(comenzar == 1);
endmodule