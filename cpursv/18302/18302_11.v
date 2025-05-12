
module marker_tracker(input  clk_cpu,
                      input  clk_camera,
                      input  cam_vsync,
                      input  go,
                      input  [20:0] track_clr,
                      input  [15:0] cam_pixel_data,
                      input  [16:0] cam_pixel_addr,
                      input  cam_write_enable,
                      output [16:0] marker_x,
                      output [16:0] marker_y,
                      output marker_valid,
                      output r_valid,
                      output b_valid,
                      output g_valid,
                      output reg new_addr,
                      output reg [9:0] cam_pixel_x,
                      output reg [9:0] cam_pixel_y,
                      output reg [16:0] last_captured,
                      output reg [31:0] sum_x,
                      output reg [31:0] sum_y,
                      output reg [31:0] sample_count,
                      output reg [10:0] tg_clr_r,
                      output reg [10:0] tg_clr_g,
                      output reg [10:0] tg_clr_b,
                      output reg [4:0] thresh,
                      output [4:0] pixel_red,
                      output [5:0] pixel_green,
                      output [4:0] pixel_blue);

  reg  [4:0] thresh;
  reg  [10:0] tg_clr_r;
  reg  [10:0] tg_clr_g;
  reg  [10:0] tg_clr_b;
  reg  [16:0] marker_y_reg,marker_x_reg,i_marker_x,i_marker_y;
  reg  [31:0] sum_x;
  reg  [31:0] sum_y;
  reg  [31:0] sample_count;
  reg  marker_valid_reg;
  reg  [9:0] cam_pixel_x;
  reg  [9:0] cam_pixel_y;
  reg  [16:0] last_captured;
  reg  new_addr;
  reg  [15:0] cam_pixel_data_reg;

  assign marker_valid = marker_valid_reg;
  assign marker_x = marker_x_reg;
  assign marker_y = marker_y_reg;
  assign pixel_red = cam_pixel_data_reg[15:11];
  assign pixel_green = cam_pixel_data_reg[10:5];
  assign pixel_blue = cam_pixel_data_reg[4:0];
  
  initial  
  begin
    thresh = 5'b0;
    tg_clr_r = 5'b0;
    tg_clr_g = 6'b0;
    tg_clr_b = 5'b0;
    marker_x_reg = 17'd0;
    marker_y_reg = 17'd0;
    sum_x = 32'd0;
    sum_y = 32'd0;
    sample_count = 32'd0;
  end
  wire r_valid;

  wire g_valid;

  wire b_valid;

  assign r_valid = pixel_red >= tg_clr_r;
  assign g_valid = pixel_green >= tg_clr_g;
  assign b_valid = pixel_blue >= tg_clr_b;
  
  always @(posedge clk_camera)
      begin
        if (cam_vsync) 
          begin
            cam_pixel_x <= 10'b0;
            cam_pixel_y <= 10'b0;
            new_addr <= 0;
            last_captured <= 0;
            cam_pixel_data_reg <= 0;
          end
        else if ((cam_write_enable == 1) && 
                 (last_captured != cam_pixel_addr)) 
          begin
            cam_pixel_y <= cam_pixel_addr/320;
            cam_pixel_x <= cam_pixel_addr-(cam_pixel_y*320);
            new_addr = 1;
            cam_pixel_data_reg <= cam_pixel_data;
            last_captured <= cam_pixel_addr;
          end
        else new_addr <= 0;
      end
  
  always @(posedge clk_cpu)
      begin
        thresh <= track_clr[20:16];
        tg_clr_r <= {5'b0,track_clr[15:11]};
        tg_clr_g <= {4'b0,track_clr[10:5]};
        tg_clr_b <= {5'b0,track_clr[4:0]};
      end
  
  always @(posedge clk_camera)
      begin
        if (cam_vsync) 
          begin
            sample_count <= 32'b0;
            sum_x <= 32'b0;
            sum_y <= 32'b0;
            if (sample_count > 0) marker_valid_reg <= 1;
            else marker_valid_reg <= 0;
            if (sample_count > 0) 
              begin
                marker_x_reg <= i_marker_x;
                marker_y_reg <= i_marker_y;
              end
              
          end
        else marker_valid_reg <= 0;
        if (!cam_vsync && new_addr && go) 
          begin
            if (r_valid && (b_valid && g_valid)) 
              begin
                sum_x <= sum_x+cam_pixel_x;
                sum_y <= cam_pixel_y+sum_y;
                sample_count <= 1+sample_count;
              end
              
          end
          
        i_marker_x <= sum_x/sample_count;
        i_marker_y <= sum_y/sample_count;
      end
endmodule

