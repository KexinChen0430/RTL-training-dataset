
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
            if ((y < ((pW+poY)+wL)) && 
                ((x < (poX+pL)) && (x > poX) && (y > (wL+poY)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((((poY+x)+((0-y)+(0-poX))) < wP) && 
                ((y > poY) && 
((x < (wP+(wW+poX))) && 
((x > (wP+poX)) && (y < (wL+poY)))))) wing <= 1;
            else if ((y > ((pW+poY)+wL)) && 
                     ((x > (wP+poX)) && (((((0-poX)+x)+y)+(-poY)) < (pL+wP))) && ((y < ((pW+poY)+(wL+wL))) && (x < (wP+(wW+poX))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

