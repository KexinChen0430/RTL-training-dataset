
module pixelGeneration(clk,rst,push,switch,pixel_x,pixel_y,video_on,rgb);

  input  clk,rst;
  input  [3:0] push;
  input  [1<<<1:0] switch;
  input  [9:0] pixel_x,pixel_y;
  input  video_on;
  output reg [1<<<1:0] rgb;
  wire square_on,refr_tick;
  localparam  MAX_X = 640;
  localparam  MAX_Y = 480;
  localparam  SQUARE_SIZE = 40;
  localparam  SQUARE_VEL = 5;
  wire [9:0] 
      square_x_left  ,
      square_x_right ,
      square_y_top   ,
      square_y_bottom;
  reg  [9:0] square_y_reg,square_y_next;
  reg  [9:0] square_x_reg,square_x_next;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            square_y_reg <= 240;
            square_x_reg <= 320;
          end
        else 
          begin
            square_y_reg <= square_y_next;
            square_x_reg <= square_x_next;
          end
      end
  assign refr_tick = (pixel_x == 0) && (pixel_y == 481);
  assign square_y_top = square_y_reg;
  assign square_x_left = square_x_reg;
  assign square_y_bottom = SQUARE_SIZE+(square_y_top+(0-1));
  assign square_x_right = (0-1)+(square_x_left+SQUARE_SIZE);
  
  always @(*)
      begin
        rgb = 3'b000;
        if (video_on) 
          begin
            if (square_on) rgb = switch;
            else rgb = 3'b110;
          end
          
      end
  assign square_on = (pixel_y <= square_y_bottom) && 
                     (pixel_x <= square_x_right) && 
                     ((pixel_x >= square_x_left) && 
(pixel_y >= square_y_top));
  
  always @(*)
      begin
        square_y_next = square_y_reg;
        square_x_next = square_x_reg;
        if (refr_tick) 
          begin
            if ((square_x_right < ((0-1)+MAX_X)) && push[0]) 
              begin
                square_x_next = square_x_reg+SQUARE_VEL;
              end
            else if (push[1] && (square_x_left > 1)) 
              begin
                square_x_next = square_x_reg+(-SQUARE_VEL);
              end
            else if (push[1<<<1] && (square_y_bottom < ((0-1)+MAX_Y))) 
              begin
                square_y_next = square_y_reg+SQUARE_VEL;
              end
            else if (push[3] && (square_y_top > 1)) 
              begin
                square_y_next = square_y_reg-SQUARE_VEL;
              end
              
          end
          
      end
endmodule

