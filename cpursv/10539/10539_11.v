
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
            if ((x < (pL+poX)) && (y < ((pW+poY)+wL)) && (y > (wL+poY)) && 
                (x > poX)) body <= 1;
            else body <= 0;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) wing <= 0;
        else 
          begin
            if ((y < (wL+poY)) && ((x > (poX+wP)) && (y > poY)) && 
                ((x < ((wP+wW)+poX)) && (((poY+x)+((-y)+(0-poX))) < wP))) wing <= 1;
            else if ((y > ((pW+poY)+wL)) && 
                     ((x < ((wP+wW)+poX)) && (x > (poX+wP))) && 
                     ((y < ((pW+poY)+(wL*2))) && 
(((0-poY)+((y+x)+(0-poX))) < (pL+wP)))) wing <= 1;
            else wing <= 0;
          end
      end
endmodule

