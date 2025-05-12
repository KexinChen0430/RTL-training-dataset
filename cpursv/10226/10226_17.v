
module ballscan(clk,screenx,screeny,ball_x,ball_y,ball_scan);

  parameter  BALLSIZE = 8;
  input  clk;
  input  [9:0] screenx;
  input  [9:0] screeny;
  input  [9:0] ball_x;
  input  [9:0] ball_y;
  output ball_scan;
  reg  [3:0] ballscanX;
  reg  ballscanY;

  
  always @(posedge clk)
      begin
        if (screenx == ((0-((1/2)*BALLSIZE))+ball_x)) ballscanX = 12;
          
        if (ballscanX > 0) ballscanX = ballscanX+(-1'b1);
          
      end
  
  always @(posedge clk)
      begin
        if (screeny == (ball_y-((1/2)*BALLSIZE))) ballscanY = 1;
          
        if (screeny == (((1/2)*BALLSIZE)+ball_y)) ballscanY = 0;
          
      end
  assign ball_scan = ballscanY && (ballscanX != 0);
endmodule

