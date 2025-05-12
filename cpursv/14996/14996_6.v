
module Selector_Casillas(clk,boton_arriba,boton_abajo,boton_izq,boton_der,boton_elige,
                         turno_p1,turno_p2,guarda_c1,guarda_c2,guarda_c3,guarda_c4,
                         guarda_c5,guarda_c6,guarda_c7,guarda_c8,guarda_c9,p1_mm,p2_mm,
                         cuadro);

  input  clk;
  input  
      boton_elige ,
      boton_arriba,
      boton_abajo ,
      boton_izq   ,
      boton_der   ;
  input  turno_p1,turno_p2;
  output reg p1_mm,p2_mm;
  output reg [3:0] cuadro;
  output reg [1:0] 
      guarda_c1,
      guarda_c2,
      guarda_c3,
      guarda_c4,
      guarda_c5,
      guarda_c6,
      guarda_c7,
      guarda_c8,
      guarda_c9;

  
  initial    cuadro <= 4'b0101;
  
  always @(posedge clk)
      begin
        if ((cuadro <= 4'b0110) & ((boton_abajo == 1'b1) & (cuadro >= 4'b0001))) cuadro = 4'b0011+cuadro;
        else if ((cuadro <= 4'b1001) & ((boton_arriba == 1'b1) & (cuadro >= 4'b0100))) cuadro = (-4'b0011)+cuadro;
        else if (((cuadro > 4'b0001) & ((cuadro != 4'b0100) & (cuadro != 4'b0111))) & ((cuadro <= 4'b1001) & (boton_izq == 1'b1))) cuadro = cuadro+(-4'b0001);
        else if (((cuadro >= 4'b0001) & (cuadro != 4'b0110)) & ((boton_der == 1'b1) & ((cuadro != 4'b0011) & (cuadro < 4'b1001)))) cuadro = 4'b0001+cuadro;
        else if (((cuadro >= 4'b0001) & (cuadro <= 4'b1001)) & (boton_elige == 1'b1)) 
          begin
            if ((turno_p1 == (1'b1 & turno_p2)) == 1'b0) 
              begin
                if (((cuadro == (guarda_c1 & 4'b0001)) != (2'b11 & guarda_c1)) != 2'b01) guarda_c1 = 2'b11;
                  
                p1_mm = 1'b1;
                p2_mm = 1'b0;
                cuadro = 4'b0101;
              end
            else if ((turno_p1 == (1'b0 & turno_p2)) == 1'b1) 
              begin
                if (((cuadro == (guarda_c1 & 4'b0001)) != (2'b11 & guarda_c1)) != 2'b01) guarda_c1 = 2'b01;
                  
                p1_mm = 1'b0;
                p2_mm = 1'b1;
                cuadro = 4'b0101;
              end
              
          end
          
      end
endmodule

