
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
            if ((y < ((pW+poY)+wL)) && (y > (wL+poY)) && 
                ((x < (pL+poX)) && (x > poX))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y < (wL+poY)) && (x < (wP+(wW+poX))) && (x > (wP+poX)) && 
                ((y > poY) && (((-poX)+((0-y)+(x+poY))) < wP))) wing <= 1;
            else if ((((y+x)+((-poY)+(-poX))) < (wP+pL)) && 
                     (y > ((pW+poY)+wL)) && 
                     ((x < (wP+(wW+poX))) && (x > (wP+poX)) && 
(y < ((pW+wL)+(wL+poY))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

