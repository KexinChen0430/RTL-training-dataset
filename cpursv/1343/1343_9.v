
module vga_sync(input  wire clk,reset,
                output wire hsync,vsync,
                output wire video_on,p_tick,
                output wire [9:0] pixel_x,pixel_y);

  localparam  HD = 640;
  localparam  HF = 48;
  localparam  HB = 16;
  localparam  HR = 96;
  localparam  VD = 480;
  localparam  VF = 27;
  localparam  VB = 16;
  localparam  VR = 1<<1;
  reg  mod2_reg;
  wire mod2_next;
  reg  [9:0] h_count_reg,h_count_next;
  reg  [9:0] v_count_reg,v_count_next;
  reg  v_sync_reg,h_sync_reg;
  wire v_sync_next,h_sync_next;
  wire h_end,v_end,pixel_tick;

  assign mod2_next = ~mod2_reg;
  assign pixel_tick = mod2_reg;
  
  always @(posedge clk or posedge reset)
      if (reset) 
        begin
          mod2_reg <= 1'b0;
          v_count_reg <= 0;
          h_count_reg <= 0;
          v_sync_reg <= 1'b0;
          h_sync_reg <= 1'b0;
        end
      else 
        begin
          mod2_reg <= mod2_next;
          v_count_reg <= v_count_next;
          h_count_reg <= h_count_next;
          v_sync_reg <= v_sync_next;
          h_sync_reg <= h_sync_next;
        end
  assign h_end = h_count_reg == (HF+((HB+(HD+HR))-1));
  assign v_end = v_count_reg == (((VR+(-1))+VF)+(VB+VD));
  
  always @(*)
      if (pixel_tick) 
        if (h_end) h_count_next = 0;
        else h_count_next = h_count_reg+1;
      else h_count_next = h_count_reg;
  
  always @(*)
      if (h_end & pixel_tick) 
        if (v_end) v_count_next = 0;
        else v_count_next = 1+v_count_reg;
      else v_count_next = v_count_reg;
  assign h_sync_next = (h_count_reg <= ((HB+(HD+HR))-1)) && 
                       (h_count_reg >= (HB+HD));
  assign v_sync_next = (v_count_reg >= (VB+VD)) && 
                       (v_count_reg <= (VB+(VD+(VR+(-1)))));
  assign video_on = (v_count_reg < VD) && (h_count_reg < HD);
  assign hsync = h_sync_reg;
  assign vsync = v_sync_reg;
  assign pixel_x = h_count_reg;
  assign pixel_y = v_count_reg;
  assign p_tick = pixel_tick;
endmodule

