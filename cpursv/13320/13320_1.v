
module vga_dis(input  clk,
               input  rst_n,
               input  [15:0] ZBcode,
               output valid,
               output [9:0] xpos,
               output [9:0] ypos,
               output hsync,
               output vsync,
               output vga_r,
               output vga_g,
               output vga_b);

  reg  [10:0] x_cnt;
  reg  [9:0] y_cnt;

  
  initial  
  begin
    x_cnt <= 0;
    y_cnt <= 0;
  end
  
  always @(posedge clk or negedge rst_n)
      if (!rst_n) x_cnt <= 11'd0;
      else if (x_cnt == 11'd1039) x_cnt <= 11'd0;
      else x_cnt <= x_cnt+1'b1;
  
  always @(posedge clk or negedge rst_n)
      if (!rst_n) y_cnt <= 10'd0;
      else if (y_cnt == 10'd665) y_cnt <= 10'd0;
      else if (x_cnt == 11'd1039) y_cnt <= y_cnt+1'b1;
        
  assign valid = (x_cnt < 11'd907) && (x_cnt >= 11'd267) && 
                 ((y_cnt >= 10'd131) && (y_cnt < 10'd531));
  assign xpos = (-11'd267)+x_cnt;
  assign ypos = y_cnt-10'd131;
  reg  hsync_r,vsync_r;

  
  initial  
  begin
    hsync_r <= 1;
    vsync_r <= 1;
  end
  
  always @(posedge clk or negedge rst_n)
      if (!rst_n) hsync_r <= 1'b1;
      else if (x_cnt == 11'd0) hsync_r <= 1'b0;
      else if (x_cnt == 11'd120) hsync_r <= 1'b1;
        
  
  always @(posedge clk or negedge rst_n)
      if (!rst_n) vsync_r <= 1'b1;
      else if (y_cnt == 10'd0) vsync_r <= 1'b0;
      else if (y_cnt == 10'd6) vsync_r <= 1'b1;
        
  assign hsync = hsync_r;
  assign vsync = vsync_r;
  wire white;

  wire [15:0] bit16;

  wire [7:0] adr;

  assign adr = |ZBcode[15:7] ? 8'h1 : ZBcode[7:0];
  ZBziku ziku(.addra({adr[7:0],ypos[3:0]}),.douta(bit16));
  assign white = bit16[(-xpos[3:0])+4'd15];
  assign vga_r = valid ? white : 1'b0;
  assign vga_g = valid ? white : 1'b0;
  assign vga_b = valid ? white : 1'b0;
endmodule

