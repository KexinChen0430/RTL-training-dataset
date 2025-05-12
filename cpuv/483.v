module Logica_Bola(
	input clock,                  
	input reset,                  
	input actualizar_posicion,    
	input revisar_bordes,         
	input choque_barra,           
	output reg [9:0] ball_x,      
	output reg [8:0] ball_y       
);
	reg dir_x_positiva;           
	reg dir_y_positiva;           
	initial
		begin
			dir_x_positiva <= 1'b1;          
			dir_y_positiva <= 1'b1;          
			ball_x <= `X_INICIAL_BOLA;       
			ball_y <= `Y_INICIAL_BOLA;       
		end
	always @(posedge clock or posedge reset)
		begin
			if(reset)                        
				begin
					dir_x_positiva <= 1'b1;
					dir_y_positiva <= 1'b1;
					ball_x <= `X_INICIAL_BOLA;
					ball_y <= `Y_INICIAL_BOLA;
				end
			else                             
				begin
					if(actualizar_posicion)   
						begin
							if(dir_x_positiva)
								ball_x <= ball_x + `VELOCIDAD_BOLA; 
							else
								ball_x <= ball_x - `VELOCIDAD_BOLA; 
							if(dir_y_positiva)
								ball_y <= ball_y + `VELOCIDAD_BOLA; 
							else
								ball_y <= ball_y - `VELOCIDAD_BOLA; 
						end
					if(revisar_bordes)
						begin
							if (ball_x > `LIMITE_DER_X_BOLA)
								begin
									ball_x <= `LIMITE_DER_X_BOLA;
									dir_x_positiva <= 1'b0;
								end
							else if(choque_barra)
								begin
									ball_x <= `X_INICIAL_BARRA + `ANCHO_BARRA;
									dir_x_positiva <= 1'b1;
								end
							if(ball_y < `LIMITE_SUP_Y_BOLA)
								begin
									ball_y <= `LIMITE_SUP_Y_BOLA;
									dir_y_positiva <= 1'b1;
								end
							else if(ball_y > `LIMITE_INF_Y_BOLA)
								begin
									ball_y <= `LIMITE_INF_Y_BOLA;
									dir_y_positiva <= 1'b0;
								end
						end
				end 
		end 
endmodule 