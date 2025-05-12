
module Decodificador(input  [6:0] Cuenta,
                     output reg [7:0] catodo1,
                     output reg [7:0] catodo2,
                     output reg [7:0] catodo3,
                     output reg [7:0] catodo4);

  
  always @(*)
      begin
        case (Cuenta)

          6'd0: begin
                catodo1 <= 8'b00000011;
                catodo2 <= 8'b00000011;
                catodo3 <= 8'b00000011;
                catodo4 <= 8'b00000011;
              end

          6'd1: begin
                catodo1 <= 8'b10011111;
                catodo2 <= 8'b00000011;
                catodo3 <= 8'b00000011;
                catodo4 <= 8'b00000011;
              end

          6'd2: begin
                catodo1 <= 8'b00100101;
                catodo2 <= 8'b00000011;
                catodo3 <= 8'b00000011;
                catodo4 <= 8'b00000011;
              end

          6'd10: begin
                catodo1 <= 8'b00000011;
                catodo2 <= 8'b10011111;
                catodo3 <= 8'b00000011;
                catodo4 <= 8'b00000011;
              end

          default: begin
                catodo1 <= 8'b10011111;
                catodo2 <= 8'b10011111;
                catodo3 <= 8'b10011111;
                catodo4 <= 8'b10011111;
              end

        endcase

      end
endmodule

