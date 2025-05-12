
module planeA(input  clk,
              input  rst,
              input  [10:0] x,
              input  [10:0] y,
              input  [10:0] poX,
              input  [10:0] poY,
              output reg wing,
              output reg body);

  parameter  pL = 40;
  parameter  pW = 10;
  parameter  wL = 15;
  parameter  wW = 15;
  parameter  wP = 15;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) body <= 0;
        else 
          begin
            if ((x < (poX+pL)) && (y > (poY+wL)) && 
                ((x > poX) && (y < ((wL+pW)+poY)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y < (poY+wL)) && ((y > poY) && (x < ((poX+wW)+wP))) && 
                ((((poY+((0-y)+x))+(0-poX)) < wP) && (x > (wP+poX)))) wing <= 1;
            else if ((x > (wP+poX)) && 
                     ((y < ((wL+pW)+(poY+wL))) && 
(((y+(x+(-poY)))+(0-poX)) < (pL+wP))) && ((x < ((poX+wW)+wP)) && (y > ((wL+pW)+poY)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

