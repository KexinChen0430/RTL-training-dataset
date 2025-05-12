
module Registrodesplazamiento  #(parameter  Width = 10)
  (CLK,reset,Enable,Indato,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9);

  input  CLK,reset,Enable;
  input  signed  [(-1)+Width:0] Indato;
  output signed  [(-1)+Width:0] Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9;
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
  assign Y0 = Aux[(-1)+Width:0];
  assign Y1 = Aux[(1<<1*Width)+(-1):Width];
  assign Y2 = Aux[(Width*3)-1:1<<1*Width];
  assign Y3 = Aux[(4*Width)-1:Width*3];
  assign Y4 = Aux[(5*Width)-1:4*Width];
  assign Y5 = Aux[(Width*6)+(-1):5*Width];
  assign Y6 = Aux[(7*Width)-1:Width*6];
  assign Y7 = Aux[(-1)+(Width*8):7*Width];
  assign Y8 = Aux[(Width*9)-1:Width*8];
  assign Y9 = Aux[(-1)+(Width*10):Width*9];
endmodule

