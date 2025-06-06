
module vga_sync_generator(input  reset,
                          input  vga_clk,
                          output blank_n,
                          output reg [10:0] next_pixel_h,
                          output reg [10:0] next_pixel_v,
                          output reg [31:0] next_pixel_addr,
                          output HS,
                          output VS);

  parameter  hori_sync = 88;
  parameter  hori_back = 47;
  parameter  hori_visible = 800;
  parameter  hori_front = 40;
  parameter  vert_sync = 3;
  parameter  vert_visible = 480;
  parameter  vert_back = 31;
  parameter  vert_front = 13;
  parameter  visible_pixels = 38400;
  reg  [10:0] h_cnt;
  reg  [10:0] v_cnt;
  wire hori_valid,vert_valid;
  wire h_sync;
  wire v_sync;
  wire [31:0] vert_line;
  wire [31:0] hori_line;

  assign vert_line = (vert_front+vert_sync)+(vert_back+vert_visible);
  assign hori_line = hori_sync+(hori_front+(hori_visible+hori_back));
  
  always @(posedge vga_clk or posedge reset)
      begin
        if (reset) 
          begin
            h_cnt <= 11'd0;
            v_cnt <= 11'd0;
          end
        else 
          begin
            if (h_cnt == (hori_line-1)) 
              begin
                h_cnt <= 11'd0;
                if (v_cnt == (vert_line-1)) v_cnt <= 11'd0;
                else v_cnt <= 11'd1+v_cnt;
              end
            else h_cnt <= h_cnt+11'd1;
          end
      end
  
  always @(posedge vga_clk or posedge reset)
      begin
        if (reset) 
          begin
            next_pixel_h <= 11'd0;
          end
        else if (h_cnt == 0) 
          begin
            next_pixel_h <= 11'd0;
          end
        else if (hori_valid && vert_valid) 
          begin
            if (next_pixel_h == hori_visible) 
              begin
                next_pixel_h <= 11'd0;
              end
            else 
              begin
                next_pixel_h <= 11'd1+next_pixel_h;
              end
          end
          
      end
  
  always @(posedge vga_clk or posedge reset)
      begin
        if (reset) 
          begin
            next_pixel_v <= 11'd0;
          end
        else if (v_cnt == 0) 
          begin
            next_pixel_v <= 11'd0;
          end
        else if ((h_cnt == 0) && vert_valid) 
          begin
            if (next_pixel_v == vert_visible) 
              begin
                next_pixel_v <= 11'd0;
              end
            else 
              begin
                next_pixel_v <= next_pixel_v+11'd1;
              end
          end
          
      end
  
  always @(posedge vga_clk or posedge reset)
      begin
        if (reset) 
          begin
            next_pixel_addr <= 32'd1;
          end
        else if (next_pixel_addr == visible_pixels) 
          begin
            next_pixel_addr <= 32'd0;
          end
        else if ((next_pixel_h < hori_visible) && blank_n) 
          begin
            next_pixel_addr <= next_pixel_addr+32'd1;
          end
          
      end
  assign HS = (h_cnt < hori_sync) ? 1'b1 : 1'b0;
  assign VS = (v_cnt < vert_sync) ? 1'b1 : 1'b0;
  assign hori_valid = (
(h_cnt <= (((hori_back+1)+hori_sync)+hori_visible)) && (h_cnt > (hori_back+hori_sync))) ? 1'b1 : 1'b0;
  assign vert_valid = ((v_cnt > (vert_back+vert_sync)) && 
                      (v_cnt <= ((vert_back+vert_visible)+vert_sync))) ? 1'b1 : 1'b0;
  assign blank_n = !(!hori_valid || !vert_valid);
endmodule

