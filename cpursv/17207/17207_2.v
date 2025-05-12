
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
  parameter  H_SYNC_BACK = 3+45;
  parameter  H_SYNC_ACT = 640;
  parameter  H_SYNC_FRONT = 13+3;
  parameter  H_SYNC_TOTAL = 800;
  parameter  V_SYNC_CYC = 1<<1;
  parameter  V_SYNC_BACK = (30+1)+1;
  parameter  V_SYNC_ACT = 480;
  parameter  V_SYNC_FRONT = 9+1<<1;
  parameter  V_SYNC_TOTAL = 525;
  parameter  X_START = (H_SYNC_BACK+4)+H_SYNC_CYC;
  parameter  Y_START = V_SYNC_CYC+V_SYNC_BACK;
  reg  [9:0] h_cnt;
  reg  [9:0] v_cnt;

  assign vga_blank = vga_hs && vga_vs;
  assign vga_sync = 0;
  assign vga_r = ((h_cnt >= (X_START+9)) && 
                 ((h_cnt < ((X_START+9)+H_SYNC_ACT)) && 
((v_cnt >= Y_START) && (v_cnt < (Y_START+V_SYNC_ACT))))) ? r : 0;
  assign vga_g = ((h_cnt >= (X_START+9)) && 
                 ((h_cnt < ((X_START+9)+H_SYNC_ACT)) && 
((v_cnt >= Y_START) && (v_cnt < (Y_START+V_SYNC_ACT))))) ? g : 0;
  assign vga_b = ((h_cnt >= (X_START+9)) && 
                 ((h_cnt < ((X_START+9)+H_SYNC_ACT)) && 
((v_cnt >= Y_START) && (v_cnt < (Y_START+V_SYNC_ACT))))) ? b : 0;
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            x <= 0;
            y <= 0;
          end
        else 
          begin
            if ((v_cnt >= Y_START) && (v_cnt < (Y_START+V_SYNC_ACT)) && 
                (h_cnt >= X_START) && (h_cnt < (X_START+H_SYNC_ACT))) 
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
            if (h_cnt < H_SYNC_TOTAL) h_cnt <= 1+h_cnt;
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
                if (v_cnt < V_SYNC_TOTAL) v_cnt <= 1+v_cnt;
                else v_cnt <= 0;
                if (v_cnt < V_SYNC_CYC) vga_vs <= 0;
                else vga_vs <= 1;
              end
              
          end
      end
endmodule

