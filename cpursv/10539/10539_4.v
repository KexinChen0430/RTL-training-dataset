
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
            if ((y < (pW+(wL+poY))) && (x < (pL+poX)) && (y > (wL+poY)) && 
                (x > poX)) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x > (poX+wP)) && 
                ((y > poY) && 
((((poY+x)+((-poX)+(0-y))) < wP) && 
((y < (wL+poY)) && (x < ((poX+wP)+wW)))))) wing <= 1;
            else if ((y > (pW+(wL+poY))) && (x > (poX+wP)) && 
                     ((y < ((pW+(wL*1<<1))+poY)) && 
(((-poX)+((-poY)+(y+x))) < (pL+wP)) && (x < ((poX+wP)+wW)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

