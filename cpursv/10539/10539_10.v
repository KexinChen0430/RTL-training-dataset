
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
            if ((x > poX) && ((x < (pL+poX)) && (y < (wL+(pW+poY)))) && 
                (y > (poY+wL))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y > poY) && (x < ((poX+wW)+wP)) && 
                ((y < (poY+wL)) && (x > (wP+poX))) && (((poY+((-poX)+x))+(-y)) < wP)) wing <= 1;
            else if ((((-poX)+((x+(0-poY))+y)) < (wP+pL)) && 
                     (y < (wL+(wL+(pW+poY)))) && (y > (wL+(pW+poY))) && 
                     ((x > (wP+poX)) && (x < ((poX+wW)+wP)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

