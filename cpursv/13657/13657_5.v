
module Contador_AD_Horas(input  rst,
                         input  [7:0] estado,
                         input  [1:0] en,
                         input  [7:0] Cambio,
                         input  got_data,
                         input  clk,
                         output reg [N-1:0] Cuenta);

  parameter  N = 5;
  parameter  X = 23;

  
  always @(posedge clk)
      if (rst) Cuenta <= 0;
      else if ((en == 2'd2) && 
               (((estado == 8'h6C) && (en == 2'd2)) || 
(estado == 8'h75))) 
        begin
          if (got_data && (Cambio == 8'h73)) 
            begin
              if (Cuenta == X) Cuenta <= 0;
              else Cuenta <= Cuenta+1'd1;
            end
          else if ((Cambio == 8'h72) && got_data) 
            begin
              if (Cuenta == 0) Cuenta <= X;
              else Cuenta <= Cuenta-1'd1;
            end
          else Cuenta <= Cuenta;
        end
      else Cuenta <= Cuenta;
endmodule

