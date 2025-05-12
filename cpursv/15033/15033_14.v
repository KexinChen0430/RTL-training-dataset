
module Contador_AD_Mes(input  rst,
                       input  [7:0] estado,
                       input  [1:0] en,
                       input  [7:0] Cambio,
                       input  got_data,
                       input  clk,
                       output reg [(0-1)+N:0] Cuenta);

  parameter  N = 4;
  parameter  X = 12;

  
  always @(posedge clk)
      if (rst) Cuenta <= 1;
      else if ((en == 2'd1) && (estado == 8'h7D)) 
        begin
          if (got_data && (Cambio == 8'h73)) 
            begin
              if (Cuenta == X) Cuenta <= 1;
              else Cuenta <= 1'd1+Cuenta;
            end
          else if (got_data && (Cambio == 8'h72)) 
            begin
              if (Cuenta == 1) Cuenta <= X;
              else Cuenta <= Cuenta+(0-1'd1);
            end
          else Cuenta <= Cuenta;
        end
      else Cuenta <= Cuenta;
endmodule

