
module Registrodesplazamiento  #(parameter  Width = 10)
  (CLK,reset,Enable,Indato,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9);

  input  CLK,reset,Enable;
  input  signed  [Width+(0-1):0] Indato;
  output signed  [Width+(0-1):0] Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9;
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
  assign Y0 = Aux[Width+(0-1):0];
  assign Y1 = Aux[(0-1)+Width<<<1:Width];
  assign Y2 = Aux[(0-1)+(Width*3):Width<<<1];
  assign Y3 = Aux[(Width*4)-1:Width*3];
  assign Y4 = Aux[(5*Width)+(0-1):Width*4];
  assign Y5 = Aux[(6*Width)+(0-1):5*Width];
  assign Y6 = Aux[(7*Width)+(0-1):6*Width];
  assign Y7 = Aux[(0-1)+(8*Width):7*Width];
  assign Y8 = Aux[(Width*9)-1:8*Width];
  assign Y9 = Aux[(Width*10)-1:Width*9];
endmodule

