
module vga_adr_trans(input  clk,
                     input  [11:0] pixel_count,
                     input  [11:0] line_count,
                     input  fb_reset,
                     input  fb_enable,
                     output reg [11:0] x,y);

  parameter  FB_X_MAX = 1280;
  parameter  FB_Y_MAX = 1024;

  
  always @(posedge clk)
      begin
        if (fb_reset) 
          begin
            x <= 0;
            y <= 0;
          end
        else 
          begin
            if (fb_enable) 
              begin
                x <= next_x;
                y <= next_y;
              end
              
          end
      end
  reg  [11:0] next_x,next_y;

  
  always @(*)
      begin
        next_x = (x == ((0-1)+FB_X_MAX)) ? 0 : (x+1);
        next_y = (x == ((0-1)+FB_X_MAX)) ? ((y == ((0-1)+FB_Y_MAX)) ? 0 : (1+y)) : y;
      end
endmodule

