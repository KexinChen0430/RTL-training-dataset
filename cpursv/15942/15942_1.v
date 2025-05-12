
module inicial(giro,entrada,saida,metais,ledVerde,ledVermelho,display,clock);

  input  giro,entrada,saida,metais,clock;
  output [1:0] ledVerde,ledVermelho;
  output [6:0] display;
  reg  [2:0] estado;
  reg  [3:0] tmp;
  reg  [1:0] tmpLedVerde,tmpLedVermelho;
  reg  [6:0] tmpDisplay;
  parameter 
       A = 3'b000,
       B = 3'b001,
       C = 3'b010,
       D = 3'b011,
       E = 3'b100;

  
  initial    estado = A;
  
  always @(posedge clock)
      begin
        tmp = {giro,entrada,saida,metais};
        case (estado)

          A: begin
                tmpLedVerde = 2'b00;
                tmpLedVermelho = 2'b00;
                tmpDisplay = 7'b1111001;
              end

          B: begin

              end

          C: begin

              end

          D: begin

              end

          E: begin

              end

          default: estado = A;

        endcase

      end
  assign ledVerde = tmpLedVerde;
  assign ledVermelho = tmpLedVermelho;
  assign display = tmpDisplay;
endmodule

