
module Registrodesplazamiento  #(parameter  Width = 10)
  (CLK,reset,Enable,Indato,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9);

  input  CLK,reset,Enable;
  input  signed  [Width+(-1):0] Indato;
  output signed  [Width+(-1):0] Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9;
  reg  [(-1)+(Width*10):0]  Aux = 0;

  
  always @(posedge CLK)
      begin
        if (reset) 
          begin
            Aux <= 0;
          end
        else if (Enable) 
          begin
            Aux <= {Indato,Aux[(-1)+(Width*10):Width]};
          end
          
      end
  assign Y0 = Aux[Width+(-1):0];
  assign Y1 = Aux[Width<<1-1:Width];
  assign Y2 = Aux[(-1)+(3*Width):Width<<1];
  assign Y3 = Aux[(4*Width)-1:3*Width];
  assign Y4 = Aux[(Width*5)+(-1):4*Width];
  assign Y5 = Aux[(6*Width)-1:Width*5];
  assign Y6 = Aux[(7*Width)+(-1):6*Width];
  assign Y7 = Aux[(Width*8)+(-1):7*Width];
  assign Y8 = Aux[(9*Width)-1:Width*8];
  assign Y9 = Aux[(-1)+(Width*10):9*Width];
endmodule

