
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
            if ((x < (pL+poX)) && (y > (wL+poY)) && 
                ((x > poX) && (y < ((pW+wL)+poY)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x < (wW+(poX+wP))) && (x > (poX+wP)) && 
                (((poY+x)+((-poX)+(0-y))) < wP) && ((y < (wL+poY)) && (y > poY))) wing <= 1;
            else if ((x > (poX+wP)) && (y < (((pW+wL)+poY)+wL)) && 
                     (((((-poY)+(-poX))+y)+x) < (pL+wP)) && ((x < (wW+(poX+wP))) && (y > ((pW+wL)+poY)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

