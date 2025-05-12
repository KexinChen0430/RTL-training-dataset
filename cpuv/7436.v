module Logica_Pong(
	input clock,
	input revisar_estado,
	input reset,
	input [8:0] barra_y,
	input [9:0] ball_x,
	input [8:0] ball_y,
	output reg choque_barra,
	output reg perdio
	);
	initial
		begin
			perdio <= 1'b0;
			choque_barra <= 1'b0;
		end
	always @ (posedge clock or posedge reset)
		begin
			if(reset)
				begin
					perdio <= 1'b0;
					choque_barra <= 1'b0;
				end
			else
				begin
					if(revisar_estado)
						begin
							if( ball_x < (`X_INICIAL_BARRA + `ANCHO_BARRA) && ((ball_y + `ALTO_BOLA )< barra_y || ball_y > barra_y + `ALTO_BARRA))
								perdio <= 1'b1;
							else
								perdio <= 1'b0;
							if( ( ball_x < (`X_INICIAL_BARRA + `ANCHO_BARRA) ) && ( ((ball_y + `ALTO_BOLA ) > barra_y) && ( ball_y < (barra_y + `ALTO_BARRA) ) ) )
								choque_barra <= 1'b1;
							else
								choque_barra <= 1'b0;
						end
				end 
		end
endmodule