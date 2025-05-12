
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
            if ((x > poX) && (y > (poY+wL)) && (y < (pW+(poY+wL))) && 
                (x < (poX+pL))) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if (((((poY+x)+(0-y))+(0-poX)) < wP) && 
                ((x > (poX+wP)) && (y > poY)) && ((x < ((poX+wP)+wW)) && (y < (poY+wL)))) wing <= 1;
            else if ((x > (poX+wP)) && (y < ((poY+wL)+(pW+wL))) && 
                     ((y > (pW+(poY+wL))) && 
(((-poY)+(((0-poX)+x)+y)) < (pL+wP))) && (x < ((poX+wP)+wW))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

