
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
            if ((y > (poY+wL)) && 
                ((x > poX) && (y < (pW+(poY+wL))) && (x < (poX+pL)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if (((poY+((x-y)+(0-poX))) < wP) && (x < (poX+(wW+wP))) && 
                (y < (poY+wL)) && ((x > (poX+wP)) && (y > poY))) wing <= 1;
            else if ((((-poY)+(y+(x+(0-poX)))) < (pL+wP)) && 
                     (y < ((pW+(poY+wL))+wL)) && 
                     ((x < (poX+(wW+wP))) && (y > (pW+(poY+wL))) && 
(x > (poX+wP)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

