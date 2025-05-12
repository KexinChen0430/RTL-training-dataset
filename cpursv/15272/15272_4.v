
module vga_renderer  #(parameter 
       WIDTH         = 800,
       H_FRONT_PORCH = 32,
       H_SYNC        = 120,
       H_BACK_PORCH  = 32,
       HEIGHT        = 480,
       V_FRONT_PORCH = 8,
       V_SYNC        = 5,
       V_BACK_PORCH  = 13)
  (input  vga_clk,
   input  reset_n,
   input  [7:0] red,
   input  [7:0] green,
   input  [7:0] blue,
   output [7:0] vga_red,
   output [7:0] vga_green,
   output [7:0] vga_blue,
   output vga_hsync,
   output vga_vsync,
   output fb_hblank,
   output fb_vblank);

  localparam 
       PIXELS_PER_LINE = (H_SYNC+WIDTH)+(H_BACK_PORCH+H_FRONT_PORCH);
  localparam 
       LINES_PER_FRAME = (V_SYNC+(V_FRONT_PORCH+HEIGHT))+V_BACK_PORCH;
  localparam  XBITS = $clog2(PIXELS_PER_LINE);
  localparam  YBITS = $clog2(LINES_PER_FRAME);
  reg  [(0-1)+XBITS:0] x_pos;
  wire  x_max = x_pos == (PIXELS_PER_LINE-1);
  reg  [YBITS-1:0] y_pos;
  wire  y_max = y_pos == ((0-1)+LINES_PER_FRAME);
  reg  hsync;

  assign vga_hsync = ~hsync;
  reg  vsync;

  assign vga_vsync = ~vsync;
  assign fb_vblank = y_pos >= HEIGHT;
  assign fb_hblank = x_pos >= WIDTH;
  
  always @(posedge vga_clk or negedge reset_n)
      begin
        if (~reset_n) 
          begin
            x_pos <= 0;
            y_pos <= 0;
            hsync <= 1'b0;
            vsync <= 1'b0;
          end
        else 
          begin
            if (x_max) 
              begin
                x_pos <= 0;
                if (y_max) 
                  begin
                    y_pos <= 0;
                  end
                else 
                  begin
                    y_pos <= y_pos+1;
                  end
              end
            else 
              begin
                x_pos <= 1+x_pos;
              end
            if (x_pos == ((0-1)+(H_FRONT_PORCH+WIDTH))) hsync <= 1'b1;
            else if (x_pos == (H_SYNC+((0-1)+(H_FRONT_PORCH+WIDTH)))) hsync <= 1'b0;
              
            if (y_pos == ((V_FRONT_PORCH+HEIGHT)+(0-1))) vsync <= 1'b1;
            else if (y_pos == (((V_SYNC+(0-1))+V_FRONT_PORCH)+HEIGHT)) vsync <= 1'b0;
              
          end
      end
  assign vga_red = ((y_pos < HEIGHT) && (x_pos < WIDTH)) ? red : 8'b0;
  assign vga_green = ((y_pos < HEIGHT) && (x_pos < WIDTH)) ? green : 8'b0;
  assign vga_blue = ((y_pos < HEIGHT) && (x_pos < WIDTH)) ? blue : 8'b0;
endmodule

