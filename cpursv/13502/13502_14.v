
module VGA2Interface(clock,reset,color_r,color_g,color_b,fb_addr_h,fb_addr_v,
                     vga_hsync,vga_vsync,vga_r,vga_g,vga_b);

  parameter  HAddrSize = 11;
  parameter  HVisibleArea = 800;
  parameter  HFrontPorch = 56;
  parameter  HSyncPulse = 120;
  parameter  HBackPorch = 64;
  parameter  VAddrSize = 11;
  parameter  VVisibleArea = 600;
  parameter  VFrontPorch = 37;
  parameter  VSyncPulse = 6;
  parameter  VBackPorch = 23;
  input  wire clock;
  input  wire reset;
  input  wire color_r;
  input  wire color_g;
  input  wire color_b;
  output wire [HAddrSize-1:0] fb_addr_h;
  output wire [VAddrSize+(-1):0] fb_addr_v;
  output wire vga_hsync;
  output wire vga_vsync;
  output wire vga_r;
  output wire vga_g;
  output wire vga_b;
  reg  [HAddrSize-1:0] s_HCounter;
  wire i_HInVisibleArea;
  wire i_HInFrontPorch;
  wire i_HInSyncPulse;
  wire i_HInBackPorch;
  reg  [VAddrSize+(-1):0] s_VCounter;
  wire i_VInVisibleArea;
  wire i_VInFrontPorch;
  wire i_VInSyncPulse;
  wire i_VInBackPorch;

  assign fb_addr_h = {HAddrSize{i_HInVisibleArea & i_VInVisibleArea}} & s_HCounter;
  assign fb_addr_v = {VAddrSize{i_HInVisibleArea & i_VInVisibleArea}} & s_VCounter;
  assign vga_hsync = ~i_HInSyncPulse;
  assign vga_vsync = ~i_VInSyncPulse;
  assign vga_r = i_VInVisibleArea & (i_HInVisibleArea & color_r);
  assign vga_g = color_g & (i_HInVisibleArea & i_VInVisibleArea);
  assign vga_b = (i_HInVisibleArea & color_b) & i_VInVisibleArea;
  assign i_HInVisibleArea = s_HCounter < HVisibleArea;
  assign i_HInFrontPorch = (s_HCounter < (HVisibleArea+HFrontPorch)) && 
                           (s_HCounter >= HVisibleArea);
  assign i_HInSyncPulse = (s_HCounter >= (HVisibleArea+HFrontPorch)) && 
                          (s_HCounter < (HSyncPulse+(HVisibleArea+HFrontPorch)));
  assign i_HInBackPorch = s_HCounter >= (HSyncPulse+(HVisibleArea+HFrontPorch));
  assign i_VInVisibleArea = s_VCounter < VVisibleArea;
  assign i_VInFrontPorch = (s_VCounter < (VFrontPorch+VVisibleArea)) && 
                           (s_VCounter >= VVisibleArea);
  assign i_VInSyncPulse = (s_VCounter >= (VFrontPorch+VVisibleArea)) && 
                          (s_VCounter < ((VSyncPulse+VFrontPorch)+VVisibleArea));
  assign i_VInBackPorch = s_VCounter >= ((VSyncPulse+VFrontPorch)+VVisibleArea);
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            s_HCounter <= HBackPorch+(HFrontPorch+(HVisibleArea+(HSyncPulse+(-1))));
          end
        else 
          begin
            if (s_HCounter == (HBackPorch+(HFrontPorch+(HVisibleArea+(HSyncPulse+(-1)))))) 
              begin
                s_HCounter <= 0;
              end
            else 
              begin
                s_HCounter <= s_HCounter+1;
              end
          end
      end
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            s_VCounter <= (VSyncPulse+((VVisibleArea+VBackPorch)+VFrontPorch))-1;
          end
        else 
          begin
            if (s_HCounter == (HBackPorch+(HFrontPorch+(HVisibleArea+(HSyncPulse+(-1)))))) 
              begin
                if (s_VCounter == ((VSyncPulse+((VVisibleArea+VBackPorch)+VFrontPorch))-1)) 
                  begin
                    s_VCounter <= 0;
                  end
                else 
                  begin
                    s_VCounter <= s_VCounter+1;
                  end
              end
            else 
              begin
                s_VCounter <= s_VCounter;
              end
          end
      end
endmodule

