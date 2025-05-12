
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
            if ((x > poX) && (x < (poX+pL)) && 
                ((y < ((pW+wL)+poY)) && (y > (wL+poY)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x < ((wW+poX)+wP)) && 
                ((y < (wL+poY)) && ((((x-poX)+(0-y))+poY) < wP)) && (y > poY) && (x > (wP+poX))) wing <= 1;
            else if ((x > (wP+poX)) && 
                     ((y > ((pW+wL)+poY)) && 
(((x+((-poY)+(-poX)))+y) < (pL+wP))) && ((y < ((pW+wL)+(wL+poY))) && (x < ((wW+poX)+wP)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

