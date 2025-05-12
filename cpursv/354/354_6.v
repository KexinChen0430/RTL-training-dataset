
module map_wall_edge(input  pixel_clk_i,
                     input  [11:0] pixel_x_i,
                     input  [11:0] pixel_y_i,
                     input  pixel_valid_i,
                     output [9:0] led_strip_address_o,
                     output led_strip_address_valid_o);

  parameter  VSYNC_VBI_LINE_COUNT = 16;
  parameter  X = 0;
  parameter  Y_START = (1+1)+VSYNC_VBI_LINE_COUNT;
  parameter  Y_END = 237+Y_START;

  assign led_strip_address_valid_o = pixel_valid_i && (pixel_y_i < Y_END) && 
                                     ((pixel_x_i == X) && (pixel_y_i >= Y_START));
  assign led_strip_address_o = (-Y_START)+pixel_y_i;
endmodule

