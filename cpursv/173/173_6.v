
module vga_controller_640_60(rst,pixel_clk,HS,VS,hcounter,vcounter,blank);

  input  rst;
  input  pixel_clk;
  output reg HS;
  output reg VS;
  output reg blank;
  output reg [10:0] hcounter;
  output reg [10:0] vcounter;
  parameter  HMAX = 800;
  parameter  HLINES = 640;
  parameter  HFP = 648;
  parameter  HSP = 744;
  parameter  VMAX = 525;
  parameter  VLINES = 480;
  parameter  VFP = 482;
  parameter  VSP = 484;
  parameter  SPP = 0;
  wire video_enable;

  
  initial  
  begin
    hcounter = 0;
    vcounter = 0;
  end
  
  always @(posedge pixel_clk)
      begin
        blank <= ~video_enable;
      end
  
  always @(posedge pixel_clk or posedge rst)
      begin
        if (rst) hcounter <= 0;
        else if (hcounter == HMAX) hcounter <= 0;
        else hcounter <= hcounter+1'b1;
      end
  
  always @(posedge pixel_clk or posedge rst)
      begin
        if (rst) vcounter <= 0;
        else if (hcounter == HMAX) 
          begin
            if (vcounter == VMAX) vcounter <= 0;
            else vcounter <= vcounter+1'b1;
          end
          
      end
  
  always @(posedge pixel_clk)
      begin
        if ((hcounter >= HFP) && (hcounter < HSP)) HS <= SPP;
        else HS <= ~SPP;
      end
  
  always @(posedge pixel_clk)
      begin
        if ((vcounter >= VFP) && (vcounter < VSP)) VS <= SPP;
        else VS <= ~SPP;
      end
  assign video_enable = ((vcounter < VLINES) && (hcounter < HLINES)) ? 1'b1 : 1'b0;
endmodule

