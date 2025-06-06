
module map_door(input  pixel_clk_i,
                input  [11:0] pixel_x_i,
                input  [11:0] pixel_y_i,
                input  pixel_valid_i,
                output reg [9:0] led_strip_address_o,
                output led_strip_address_valid_o);

  parameter  VSYNC_VBI_LINE_COUNT = 16;
  parameter X_V1;
  parameter X_V2;
  parameter Y_V;
  parameter X_H;
  parameter Y_H;
  parameter  V_LEN = 127;
  parameter  H_LEN = 65;
  parameter  X1 = X_V1;
  parameter  Y1_START = VSYNC_VBI_LINE_COUNT+Y_V;
  parameter  Y1_END = V_LEN+Y1_START;
  parameter  X2_START = X_H;
  parameter  X2_END = X2_START+H_LEN;
  parameter  Y2 = Y_H+VSYNC_VBI_LINE_COUNT;
  parameter  X3 = X_V2;
  parameter  Y3_START = VSYNC_VBI_LINE_COUNT+Y_V;
  parameter  Y3_END = Y3_START+V_LEN;
  wire 
       zone1_enable = (pixel_y_i >= Y1_START) && 
((pixel_y_i < Y1_END) && (pixel_x_i == X1));
  wire [9:0]  zone1_address = (0-(pixel_y_i-Y1_START))+V_LEN;
  wire 
       zone2_enable = (pixel_y_i == Y2) && (pixel_x_i < X2_END) && 
(pixel_x_i >= X2_START);
  wire [9:0]  zone2_address = V_LEN+(pixel_x_i+(0-X2_START));
  wire 
       zone3_enable = (pixel_y_i >= Y3_START) && (pixel_y_i < Y3_END) && 
(pixel_x_i == X3);
  wire [9:0] 
       zone3_address = ((pixel_y_i+H_LEN)+V_LEN)+(0-Y3_START);
  wire 
       zone_enable = zone3_enable || (zone2_enable || zone1_enable);

  assign led_strip_address_valid_o = pixel_valid_i && zone_enable;
  
  always @(zone1_enable or zone2_enable or zone3_enable or zone1_address or zone2_address or zone3_address)
      begin
        if (zone3_enable) 
          begin
            led_strip_address_o = zone3_address;
          end
        else if (zone2_enable) 
          begin
            led_strip_address_o = zone2_address;
          end
        else 
          begin
            led_strip_address_o = zone1_address;
          end
      end
endmodule

