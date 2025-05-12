module MUX_DECO( 
input wire [7:0]seleccion, 
input wire [7:0]tecla, 
input wire [7:0] tecla2, 
input wire [7:0] tecla3, 
input wire [7:0]RG1, 
input wire [7:0]RG2, 
input wire [7:0]RG3, 
input wire listo, 
input wire listo_lee, 
input wire listo_escribe, 
output reg [7:0]salida_mux_deco 
    );
   always @(seleccion, listo, listo_lee,listo_escribe) 
      case (seleccion) 
         8'b00000000: salida_mux_deco = 8'h00; 
         8'b00000001: salida_mux_deco = {7'b0000000,listo}; 
         8'b00000010: salida_mux_deco = {7'b0000000,listo_escribe}; 
         8'b00000011: salida_mux_deco = {7'b0000000,listo_lee}; 
      endcase
endmodule