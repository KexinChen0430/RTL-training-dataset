module Logica_Barra(
	input clock, 
	input reset, 
	input actualizar_posicion, 
	input revisar_bordes, 
	input up_sync, 
	input down_sync, 
	output reg [8:0] barra_y); 
	parameter LIMITE_INF_Y = 480 - `ALTO_BARRA; 
	parameter LIMITE_SUP_Y = `VELOCIDAD_BARRA; 
	initial
		begin
			barra_y <= `Y_INICIAL_BARRA; 
		end
	always @ (posedge clock or posedge reset) 
		begin
			if(reset) 
				begin
					barra_y <= `Y_INICIAL_BARRA; 
				end 
			else 
				begin
					if(actualizar_posicion) 
						begin
							if(up_sync) 
								barra_y <= barra_y - `VELOCIDAD_BARRA ; 
							if(down_sync) 
								barra_y <= barra_y + `VELOCIDAD_BARRA ; 
						end
					if(revisar_bordes) 
						begin
							if ( barra_y > LIMITE_INF_Y ) 
								barra_y <= LIMITE_INF_Y; 
							else if(barra_y < LIMITE_SUP_Y) 
								barra_y <= LIMITE_SUP_Y; 
							else
								barra_y <= barra_y; 
						end
				end 
		end 
endmodule