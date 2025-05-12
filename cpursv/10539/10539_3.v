
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
            if ((y < ((poY+wL)+pW)) && (x > poX) && 
                ((x < (poX+pL)) && (y > (poY+wL)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y > poY) && (x > (poX+wP)) && (((x-y)+(poY+(-poX))) < wP) && 
                (x < (poX+(wP+wW))) && (y < (poY+wL))) wing <= 1;
            else if ((y < ((pW+wL)+(poY+wL))) && 
                     ((y > ((poY+wL)+pW)) && (x < (poX+(wP+wW))) && 
((((-poY)+(y+(x-poX))) < (wP+pL)) && (x > (poX+wP))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

