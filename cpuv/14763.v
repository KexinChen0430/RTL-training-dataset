module teclado( 
    input      [7:0] ps2_data, 
    output reg [4:0] val, 
    output reg [2:0] control, 
    output [7:0] leds 
  );
    localparam CTRL_NUMERO    = 3'd1; 
    localparam CTRL_ENTER     = 3'd2; 
    localparam CTRL_FLECHA    = 3'd3; 
    localparam CTRL_OPERACION = 3'd4; 
    localparam CERO   = 8'h45;
    localparam UNO    = 8'h16;
    localparam DOS    = 8'h1E;
    localparam TRES   = 8'h26;
    localparam CUATRO = 8'h25;
    localparam CINCO  = 8'h2E;
    localparam SEIS   = 8'h36;
    localparam SIETE  = 8'h3D;
    localparam OCHO   = 8'h3E;
    localparam NUEVE  = 8'h46;
    localparam A      = 8'h1C;
    localparam B      = 8'h32;
    localparam C      = 8'h21;
    localparam D      = 8'h23;
    localparam E      = 8'h24;
    localparam F      = 8'h2B;
    localparam O      = 8'h44;
    localparam Y      = 8'h35;
    localparam SUMA   = 8'h1B;
    localparam RESTA  = 8'h2D;
    localparam MUL    = 8'h3A;
    localparam ENTER  = 8'h5A;
    localparam ARRIBA    =8'h75;
    localparam ABAJO     =8'h72;
    localparam IZQUIERDA =8'h6B;
    localparam DERECHA   =8'h74;
    wire reloj_lento; 
    assign leds[4:0]= val; 
    assign leds[7:5]= control; 
    always @(*) begin 
        case(ps2_data) 
           CERO: begin
                    val=5'd0;
                    control=CTRL_NUMERO;
            end
            default: begin
                    val=5'd0;
                    control=3'd0;
            end
            endcase
    end
endmodule