
module timing_generator_VGA(input  wire clk,reset,
                            output wire hsync,vsync,video_on,p_tick,
                            output wire [9:0] pixel_x,pixel_y);

  localparam  HD = 640;
  localparam  HF = 48;
  localparam  HB = 16;
  localparam  HR = 96;
  localparam  VD = 480;
  localparam  VF = 10;
  localparam  VB = 33;
  localparam  VR = 1+1;
  reg  cuenta,CV;
  reg  [9:0] h_count_reg,h_count_next;
  reg  [9:0] v_count_reg,v_count_next;
  reg  h_sync_reg,v_sync_reg;
  wire h_sync_next,v_sync_next;
  wire h_end,v_end;
  wire pixel_tick;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            h_count_reg <= 0;
            v_count_reg <= 0;
            h_sync_reg <= 1'b0;
            v_sync_reg <= 1'b0;
          end
        else 
          begin
            h_count_reg <= h_count_next;
            v_count_reg <= v_count_next;
            h_sync_reg <= h_sync_next;
            v_sync_reg <= v_sync_next;
          end
      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            cuenta <= 0;
            CV <= 0;
          end
        else 
          begin
            if (cuenta == 1'b1) 
              begin
                cuenta <= 0;
                CV <= ~CV;
              end
            else cuenta <= 1'b1+cuenta;
          end
      end
  assign pixel_tick = CV;
  assign h_end = h_count_reg == ((HF+(HB+HR))+((0-1)+HD));
  assign v_end = v_count_reg == (((((0-1)+VR)+VB)+VD)+VF);
  
  always @(negedge pixel_tick)
      begin
        if (h_end) h_count_next = 0;
        else h_count_next = 1'b1+h_count_reg;
      end
  
  always @(negedge pixel_tick)
      begin
        if (h_end) 
          if (v_end) v_count_next = 0;
          else v_count_next = 1'b1+v_count_reg;
        else v_count_next = v_count_reg;
      end
  assign h_sync_next = (h_count_reg >= (HB+HD)) && 
                       (h_count_reg <= (((0-1)+HD)+(HB+HR)));
  assign v_sync_next = (v_count_reg >= (VD+VB)) && 
                       (v_count_reg <= ((((0-1)+VR)+VB)+VD));
  assign video_on = (v_count_reg < VD) && (h_count_reg < HD);
  assign hsync = ~h_sync_reg;
  assign vsync = ~v_sync_reg;
  assign pixel_x = h_count_reg;
  assign pixel_y = v_count_reg;
  assign p_tick = pixel_tick;
endmodule

