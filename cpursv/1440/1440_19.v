
module phy_emulation  #(parameter  DLY = 1, INTERLACE = 0, DATA_WIDTH = 24)
  (input  wire clk,
   input  wire rst,
   input  wire vid_ce,
   input  wire hsync,
   input  wire vsync,
   input  wire de,
   input  wire vid_field_id,
   input  wire [DATA_WIDTH+(-1):0] video_data,
   output reg error_out,
   output reg frame_complete);

  reg  [13:0] pixel_count;
  reg  [13:0] line_count;
  reg  [DATA_WIDTH+(-1):0] video_data_1;
  reg  de_1;
  reg  de_2;
  reg  hsync_1;
  reg  vsync_1;
  wire [DATA_WIDTH+(-1):0] expected_video_data;
  reg   count_valid = 0;
  wire vsync_rising;
  reg  vblank;
  wire compare_valid;

  assign vsync_rising = vsync & !vsync_1;
  assign compare_valid = count_valid & (de & !frame_complete);
  
  always @(posedge clk)
      begin
        if (vid_ce) 
          begin
            video_data_1 <= video_data;
            de_1 <= de;
            de_2 <= de_1;
            hsync_1 <= hsync;
            vsync_1 <= vsync;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (vid_ce) 
          begin
            if (hsync || rst) pixel_count <= 0;
            else if (de_1) pixel_count <= 1+pixel_count;
              
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            line_count <= 0;
            count_valid <= 0;
            frame_complete <= 0;
          end
        else if (vid_ce) 
          begin
            if (vsync_rising) 
              begin
                vblank <= 1;
                line_count <= 0;
                if (vid_field_id || 
                    (((!INTERLACE || count_valid) && vid_field_id) || 
!INTERLACE)) count_valid <= 1;
                  
                if (
((!INTERLACE && count_valid) || 
((!INTERLACE || count_valid) && vid_field_id)) && count_valid) frame_complete <= 1;
                  
              end
            else if (&line_count) 
              begin
                $display("Line counter reached maximum value. Test error.");
                $stop;
              end
            else if (!de_1 & de) 
              begin
                if (!vblank) line_count <= 1+line_count;
                  
                vblank <= 0;
              end
              
          end
          
      end
  assign expected_video_data = vid_field_id ? {~line_count,~pixel_count[11:0]} : {line_count,pixel_count[11:0]};
  
  always @(posedge clk)
      begin
        if (vid_ce) 
          begin
            error_out <= 0;
            if (compare_valid) 
              begin
                #DLY ;
                #DLY 
                  if (video_data_1 != expected_video_data) 
                    begin
                      $display("Data Mismatch. Expected: %h, received: %h. Test error.",
                               expected_video_data,video_data_1);
                      error_out <= 1;
                      $display(*******************************);
                      $display("** ERROR. TEST FAILED  !!!");
                      $display(*******************************);
                      $stop;
                    end
                    

              end
              
          end
          
      end
endmodule

