module VideoModeDecoder(mode, h_values, v_values); 
  input [`VIDEO_MODE_WIDTH-1:0] mode; 
  output [`VIDEO_COUNT_WIDTH*9-1:0] h_values; 
  output [`VIDEO_COUNT_WIDTH*9-1:0] v_values; 
  assign h_values = { `VGA_640X480_60HZ_H_VISIBLE_LENGTH,
                      `VGA_640X480_60HZ_H_FRONT_LENGTH,
                      `VGA_640X480_60HZ_H_SYNC_LENGTH,
                      `VGA_640X480_60HZ_H_BACK_LENGTH,
                      `VGA_640X480_60HZ_H_SYNC_START,
                      `VGA_640X480_60HZ_H_BACK_START,
                      `VGA_640X480_60HZ_H_VISIBLE_START,
                      `VGA_640X480_60HZ_H_FRONT_START,
                      `VGA_640X480_60HZ_H_TOTAL_LENGTH };
  assign v_values = { `VGA_640X480_60HZ_V_VISIBLE_LENGTH,
                      `VGA_640X480_60HZ_V_FRONT_LENGTH,
                      `VGA_640X480_60HZ_V_SYNC_LENGTH,
                      `VGA_640X480_60HZ_V_BACK_LENGTH,
                      `VGA_640X480_60HZ_V_SYNC_START,
                      `VGA_640X480_60HZ_V_BACK_START,
                      `VGA_640X480_60HZ_V_VISIBLE_START,
                      `VGA_640X480_60HZ_V_FRONT_START,
                      `VGA_640X480_60HZ_V_TOTAL_LENGTH };
endmodule 