
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
            if ((x > poX) && 
                ((y > (wL+poY)) && 
((x < (poX+pL)) && (y < (wL+(poY+pW)))))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x < (poX+(wW+wP))) && (y < (wL+poY)) && 
                ((y > poY) && (((x-poX)+((-y)+poY)) < wP)) && (x > (poX+wP))) wing <= 1;
            else if (((((-poY)+x)+(y+(-poX))) < (wP+pL)) && 
                     ((x < (poX+(wW+wP))) && (x > (poX+wP)) && 
((y < (wL+(wL+(poY+pW)))) && (y > (wL+(poY+pW)))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

