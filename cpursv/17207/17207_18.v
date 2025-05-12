
module vga(input  wire clk,
           input  wire rst,
           input  wire [7:0] r,
           input  wire [7:0] g,
           input  wire [7:0] b,
           output reg [9:0] x,
           output reg [9:0] y,
           output wire [7:0] vga_r,
           output wire [7:0] vga_g,
           output wire [7:0] vga_b,
           output reg vga_hs,
           output reg vga_vs,
           output wire vga_sync,
           output wire vga_blank);

  parameter  H_SYNC_CYC = 96;
  parameter  H_SYNC_BACK = 45+3;
  parameter  H_SYNC_ACT = 640;
  parameter  H_SYNC_FRONT = 3+13;
  parameter  H_SYNC_TOTAL = 800;
  parameter  V_SYNC_CYC = 2;
  parameter  V_SYNC_BACK = 30+2;
  parameter  V_SYNC_ACT = 480;
  parameter  V_SYNC_FRONT = 9+2;
  parameter  V_SYNC_TOTAL = 525;
  parameter  X_START = (4+H_SYNC_CYC)+H_SYNC_BACK;
  parameter  Y_START = V_SYNC_BACK+V_SYNC_CYC;
  reg  [9:0] h_cnt;
  reg  [9:0] v_cnt;

  assign vga_blank = vga_hs && vga_vs;
  assign vga_sync = 0;
  assign vga_r = ((v_cnt < (V_SYNC_ACT+Y_START)) && 
                 ((v_cnt >= Y_START) && (h_cnt >= (X_START+9)) && 
(h_cnt < ((9+H_SYNC_ACT)+X_START)))) ? r : 0;
  assign vga_g = ((v_cnt < (V_SYNC_ACT+Y_START)) && 
                 ((v_cnt >= Y_START) && (h_cnt >= (X_START+9)) && 
(h_cnt < ((9+H_SYNC_ACT)+X_START)))) ? g : 0;
  assign vga_b = ((v_cnt < (V_SYNC_ACT+Y_START)) && 
                 ((v_cnt >= Y_START) && (h_cnt >= (X_START+9)) && 
(h_cnt < ((9+H_SYNC_ACT)+X_START)))) ? b : 0;
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            x <= 0;
            y <= 0;
          end
        else 
          begin
            if ((v_cnt >= Y_START) && (h_cnt >= X_START) && 
                ((v_cnt < (V_SYNC_ACT+Y_START)) && 
(h_cnt < (H_SYNC_ACT+X_START)))) 
              begin
                x <= h_cnt-X_START;
                y <= v_cnt-Y_START;
              end
              
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            h_cnt <= 0;
            vga_hs <= 0;
          end
        else 
          begin
            if (h_cnt < H_SYNC_TOTAL) h_cnt <= h_cnt+1;
            else h_cnt <= 0;
            if (h_cnt < H_SYNC_CYC) vga_hs <= 0;
            else vga_hs <= 1;
          end
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            v_cnt <= 0;
            vga_vs <= 0;
          end
        else 
          begin
            if (h_cnt == 0) 
              begin
                if (v_cnt < V_SYNC_TOTAL) v_cnt <= v_cnt+1;
                else v_cnt <= 0;
                if (v_cnt < V_SYNC_CYC) vga_vs <= 0;
                else vga_vs <= 1;
              end
              
          end
      end
endmodule

