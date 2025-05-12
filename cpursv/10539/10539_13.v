
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
                ((x > poX) && (y < ((wL+poY)+pW)))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y > poY) && 
                ((((poY+(-y))+(x-poX)) < wP) && (x < (wW+(wP+poX))) && 
((y < (wL+poY)) && (x > (wP+poX))))) wing <= 1;
            else if ((x > (wP+poX)) && (y > ((wL+poY)+pW)) && 
                     (y < ((wL+pW)+(wL+poY))) && 
                     ((((y+(-poY))+(x-poX)) < (wP+pL)) && 
(x < (wW+(wP+poX))))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

