
module Registrodesplazamiento  #(parameter  Width = 10)
  (CLK,reset,Enable,Indato,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9);

  input  CLK,reset,Enable;
  input  signed  [(-1)+Width:0] Indato;
  output signed  [(-1)+Width:0] Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9;
  reg  [(Width*10)-1:0]  Aux = 0;

  
  always @(posedge CLK)
      begin
        if (reset) 
          begin
            Aux <= 0;
          end
        else if (Enable) 
          begin
            Aux <= {Indato,Aux[(Width*10)-1:Width]};
          end
          
      end
  assign Y0 = Aux[(-1)+Width:0];
  assign Y1 = Aux[(-1)+(Width*1<<1):Width];
  assign Y2 = Aux[(-1)+(Width*3):Width*1<<1];
  assign Y3 = Aux[(Width*4)+(-1):Width*3];
  assign Y4 = Aux[(5*Width)+(-1):Width*4];
  assign Y5 = Aux[(Width*6)-1:5*Width];
  assign Y6 = Aux[(Width*7)-1:Width*6];
  assign Y7 = Aux[(Width*8)-1:Width*7];
  assign Y8 = Aux[(-1)+(Width*9):Width*8];
  assign Y9 = Aux[(Width*10)-1:Width*9];
endmodule

