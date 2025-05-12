
module vga_time_generator(clk,reset_n,h_disp,h_fporch,h_sync,h_bporch,v_disp,v_fporch,
                          v_sync,v_bporch,hs_polarity,vs_polarity,frame_interlaced,
                          vga_hs,vga_vs,vga_de,pixel_i_odd_frame,pixel_x,pixel_y);

  input  clk;
  input  reset_n;
  input  [11:0] h_disp;
  input  [11:0] h_fporch;
  input  [11:0] h_sync;
  input  [11:0] h_bporch;
  input  [11:0] v_disp;
  input  [11:0] v_fporch;
  input  [11:0] v_sync;
  input  [11:0] v_bporch;
  input  hs_polarity;
  input  vs_polarity;
  input  frame_interlaced;
  output reg vga_hs;
  output reg vga_vs;
  output vga_de;
  output reg pixel_i_odd_frame;
  output reg [11:0] pixel_x;
  output reg [11:0] pixel_y;
  reg  [11:0] h_total;
  reg  [11:0] h_total_half;
  reg  [11:0] h_pixel_start;
  reg  [11:0] h_pixel_end;
  reg  h_sync_polarity;
  reg  vga_h_de;
  wire h_de;
  wire [11:0] h_valid_pixel_count;
  wire h_last_pixel;

  assign h_de = ((h_counter < h_pixel_end) && 
                (h_counter >= h_pixel_start)) ? 1'b1 : 1'b0;
  assign h_valid_pixel_count = h_counter+(-h_pixel_start);
  assign h_last_pixel = ((h_counter+1) == h_total) ? 1'b1 : 1'b0;
  reg  [11:0] h_counter;

  reg  [11:0] h_cur_disp;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            h_counter <= 12'h000;
            vga_hs <= hs_polarity ? 1'b1 : 1'b0;
            vga_h_de <= 1'b0;
            pixel_x <= 12'hfff;
            h_cur_disp <= 0;
          end
        else if (h_cur_disp != h_disp) 
          begin
            h_cur_disp <= h_disp;
            h_total <= (h_disp+(h_fporch+h_sync))+h_bporch;
            h_total_half <= (h_disp+(h_fporch+h_sync))+h_bporch>>1;
            h_pixel_start <= h_bporch+h_sync;
            h_pixel_end <= (h_bporch+h_sync)+h_disp;
            h_sync_polarity <= hs_polarity;
            h_counter <= 12'h000;
            vga_hs <= hs_polarity ? 1'b1 : 1'b0;
            vga_h_de <= 1'b0;
            pixel_x <= 12'hfff;
          end
        else 
          begin
            if (!h_last_pixel) h_counter <= h_counter+1'b1;
            else h_counter <= 0;
            if (h_counter < h_sync) vga_hs <= h_sync_polarity ? 1'b1 : 1'b0;
            else vga_hs <= h_sync_polarity ? 1'b0 : 1'b1;
            pixel_x <= h_de ? h_valid_pixel_count : 12'hfff;
            vga_h_de <= h_de;
          end
      end
  reg  vga_v_de;

  reg  [11:0] v_total;

  reg  [11:0] v_pixel_start;

  reg  [11:0] v_pixel_end;

  reg  v_sync_polarity;

  reg  v_interlaced;

  reg  gen_field1_sync;

  reg  f0_to_f1;

  wire [11:0] v_field_total;

  wire [11:0] v_field_disp;

  wire [11:0] v_valid_line_count;

  wire v_de;

  assign v_de = ((v_counter < v_pixel_end) && 
                (v_counter >= v_pixel_start)) ? 1'b1 : 1'b0;
  assign v_valid_line_count = v_counter-v_pixel_start;
  assign v_field_disp = frame_interlaced ? v_disp>>1 : v_disp;
  assign v_field_total = v_fporch+(v_sync+(v_bporch+v_field_disp));
  reg  [11:0] v_counter;

  reg  [11:0] v_cur_disp;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            v_counter <= 12'h000;
            vga_vs <= vs_polarity ? 1'b1 : 1'b0;
            vga_v_de <= 1'b0;
            pixel_y <= 12'hfff;
            pixel_i_odd_frame <= 1'b0;
            v_cur_disp <= 0;
          end
        else if (v_cur_disp != v_disp) 
          begin
            v_cur_disp <= v_disp;
            v_pixel_start <= v_bporch+v_sync;
            v_pixel_end <= v_sync+(v_bporch+v_field_disp);
            v_total <= v_field_total;
            v_sync_polarity <= vs_polarity;
            v_interlaced <= frame_interlaced;
            f0_to_f1 <= 1'b0;
            v_counter <= 12'h000;
            vga_vs <= vs_polarity ? 1'b1 : 1'b0;
            vga_v_de <= 1'b0;
            pixel_y <= 12'hfff;
            pixel_i_odd_frame <= 1'b0;
          end
        else if (f0_to_f1 && 
                 ((f0_to_f1 || pixel_i_odd_frame) && (h_counter == 0))) f0_to_f1 <= 1'b0;
        else if ((f0_to_f1 || pixel_i_odd_frame) && 
                 (h_counter == h_total_half)) 
          begin
            if (f0_to_f1) pixel_i_odd_frame <= 1'b1;
            else 
              begin
                if (v_counter < v_sync) vga_vs <= v_sync_polarity ? 1'b1 : 1'b0;
                else vga_vs <= v_sync_polarity ? 1'b0 : 1'b1;
              end
          end
        else if (h_counter == 0) 
          begin
            if ((v_counter+1) < v_total) v_counter <= v_counter+1'b1;
            else 
              begin
                v_counter <= 0;
                if (v_interlaced) 
                  begin
                    if (pixel_i_odd_frame) pixel_i_odd_frame <= 1'b0;
                    else f0_to_f1 <= 1'b1;
                  end
                  
              end
            if (!pixel_i_odd_frame) 
              begin
                if (v_counter < v_sync) vga_vs <= v_sync_polarity ? 1'b1 : 1'b0;
                else vga_vs <= v_sync_polarity ? 1'b0 : 1'b1;
              end
              
            vga_v_de <= v_de;
            if (!v_de) pixel_y <= 12'hfff;
            else if (!v_interlaced) pixel_y <= v_valid_line_count;
            else if (pixel_i_odd_frame) pixel_y <= 1+v_valid_line_count<<<1;
            else pixel_y <= v_valid_line_count<<<1;
          end
          
      end
  assign vga_de = vga_v_de & vga_h_de;
endmodule

