
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
            if ((y < ((wL+pW)+poY)) && (y > (poY+wL)) && 
                ((x < (pL+poX)) && (x > poX))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x > (wP+poX)) && (y < (poY+wL)) && 
                (((((-y)+poY)+(x-poX)) < wP) && (y > poY) && 
(x < ((wP+poX)+wW)))) wing <= 1;
            else if (((x+(y+((0-poX)+(-poY)))) < (pL+wP)) && 
                     ((y < (poY+(wL+(wL+pW)))) && (x < ((wP+poX)+wW))) && ((y > ((wL+pW)+poY)) && (x > (wP+poX)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

