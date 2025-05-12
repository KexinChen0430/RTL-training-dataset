
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
            if ((y < ((wL+poY)+pW)) && (x > poX) && 
                ((y > (wL+poY)) && (x < (pL+poX)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((x < (poX+(wP+wW))) && 
                ((y > poY) && ((((0-poX)+(-y))+(poY+x)) < wP) && 
(x > (poX+wP))) && (y < (wL+poY))) wing <= 1;
            else if ((y > ((wL+poY)+pW)) && 
                     ((y < ((wL+poY)+(pW+wL))) && (x < (poX+(wP+wW))) && 
((x > (poX+wP)) && ((((y+x)+(-poY))+(0-poX)) < (pL+wP))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

