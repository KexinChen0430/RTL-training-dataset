
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
            if ((y > (wL+poY)) && (x < (pL+poX)) && (y < ((pW+poY)+wL)) && 
                (x > poX)) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y > poY) && (y < (wL+poY)) && 
                ((((0-poX)+((x-y)+poY)) < wP) && (x > (wP+poX)) && 
(x < (poX+(wP+wW))))) wing <= 1;
            else if ((((y+(-poY))+(x-poX)) < (pL+wP)) && 
                     (x < (poX+(wP+wW))) && 
                     ((x > (wP+poX)) && (y > ((pW+poY)+wL)) && 
(y < ((poY+wL<<1)+pW)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

