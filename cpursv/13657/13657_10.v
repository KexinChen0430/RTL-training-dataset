
module Contador_AD_Horas(input  rst,
                         input  [7:0] estado,
                         input  [1:0] en,
                         input  [7:0] Cambio,
                         input  got_data,
                         input  clk,
                         output reg [N+(0-1):0] Cuenta);

  parameter  N = 5;
  parameter  X = 23;

  
  always @(posedge clk)
      if (rst) Cuenta <= 0;
      else if (
((en == 2'd2) && 
(((en == 2'd2) || (estado == 8'h75)) && 
(estado == 8'h6C))) || ((estado == 8'h75) && (en == 2'd2))) 
        begin
          if ((Cambio == 8'h73) && got_data) 
            begin
              if (Cuenta == X) Cuenta <= 0;
              else Cuenta <= Cuenta+1'd1;
            end
          else if (got_data && (Cambio == 8'h72)) 
            begin
              if (Cuenta == 0) Cuenta <= X;
              else Cuenta <= Cuenta+(0-1'd1);
            end
          else Cuenta <= Cuenta;
        end
      else Cuenta <= Cuenta;
endmodule

