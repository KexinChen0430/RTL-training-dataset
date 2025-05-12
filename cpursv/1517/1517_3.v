
module timing_gen  #(parameter  DLY = 1, INTERLACE = 0, DATA_WIDTH = 24)
  (input  wire clk,
   input  wire rst,
   input  wire ce,
   input  wire [13:0] active_lines,
   input  wire [13:0] total_lines,
   input  wire [13:0] vsync_start,
   input  wire [13:0] vsync_end,
   input  wire [13:0] active_pixels,
   input  wire [13:0] total_pixels,
   input  wire [13:0] hsync_start,
   input  wire [13:0] hsync_end,
   output wire hsync,
   output wire vsync,
   output wire hblank,
   output wire vblank,
   output reg  field_id = 0,
   output wire de,
   output wire [DATA_WIDTH-1:0] video_data);

  reg  [13:0]  pixel_count = 0;
  reg  [13:0]  line_count = 0;
  reg  [8:0]  frame_count = 0;

  
  always @(posedge clk)
      begin
        if (rst) 
          #DLY pixel_count <= 0;
        else if (ce) 
          begin
            if (pixel_count == ((-1)+total_pixels)) 
              #DLY pixel_count <= 0;
            else 
              #DLY pixel_count <= 1+pixel_count;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            line_count <= #DLY 0;
            frame_count <= #DLY 0;
            field_id <= #DLY 0;
          end
        else if (ce) 
          begin
            if (frame_count >= 13) 
              begin
                $display("Frame counter timed out. Test error.");
                $display(*******************************);
                $display("** ERROR. TEST FAILED  !!!");
                $display(*******************************);
                $stop;
              end
            else if (pixel_count == ((-1)+total_pixels)) 
              if (line_count == (total_lines+(-1))) 
                begin
                  line_count <= 0;
                  frame_count <= frame_count+1;
                  if (INTERLACE) field_id <= ~field_id;
                  else field_id <= 0;
                end
              else line_count <= #DLY 1+line_count;
              
          end
          
      end
  assign hsync = (pixel_count <= hsync_end) && 
                 (pixel_count >= hsync_start);
  assign vsync = (line_count >= vsync_start) && 
                 (line_count <= vsync_end);
  assign hblank = !(pixel_count <= ((-1)+active_pixels));
  assign vblank = !(line_count <= ((-1)+active_lines));
  assign de = (line_count <= ((-1)+active_lines)) && 
              (pixel_count <= ((-1)+active_pixels));
  assign video_data = {line_count,pixel_count[11:0]};
endmodule

