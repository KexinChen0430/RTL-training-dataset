
module osd(input  pclk,
           input  sck,
           input  ss,
           input  sdi,
           input  [5:0] red_in,
           input  [5:0] green_in,
           input  [5:0] blue_in,
           input  hs_in,
           input  vs_in,
           input  scanline_ena_h,
           output [5:0] red_out,
           output [5:0] green_out,
           output [5:0] blue_out,
           output hs_out,
           output vs_out);

  parameter  OSD_X_OFFSET = 10'd0;
  parameter  OSD_Y_OFFSET = 10'd0;
  parameter  OSD_COLOR = 3'd1;
  localparam  OSD_WIDTH = 10'd256;
  localparam  OSD_HEIGHT = 10'd128;
  reg  [7:0] sbuf;
  reg  [7:0] cmd;
  reg  [4:0] cnt;
  reg  [10:0] bcnt;
  reg  osd_enable;
  reg  [7:0] osd_buffer[2047:0];

  
  always @(posedge sck or posedge ss)
      begin
        if (ss == 1'b1) 
          begin
            cnt <= 5'd0;
            bcnt <= 11'd0;
          end
        else 
          begin
            sbuf <= {sbuf[6:0],sdi};
            if (cnt < 15) cnt <= cnt+4'd1;
            else cnt <= 4'd8;
            if (cnt == 7) 
              begin
                cmd <= {sbuf[6:0],sdi};
                bcnt <= {sbuf[1:0],sdi,8'h00};
                if (sbuf[6:3] == 4'b0100) osd_enable <= sdi;
                  
              end
              
            if ((cnt == 15) && (cmd[7:3] == 5'b00100)) 
              begin
                osd_buffer[bcnt] <= {sbuf[6:0],sdi};
                bcnt <= 11'd1+bcnt;
              end
              
          end
      end
  reg  [9:0] h_cnt;

  reg  hsD,hsD2;

  reg  [9:0] hs_low,hs_high;

  wire  hs_pol = hs_high < hs_low;

  wire [9:0]  h_dsp_width = hs_pol ? hs_low : hs_high;

  wire [9:0]  h_dsp_ctr = {1'b0,h_dsp_width[9:1]};

  reg   scanline = 0;

  
  always @(posedge pclk)
      begin
        hsD <= hs_in;
        hsD2 <= hsD;
        if (hsD2 && !hsD) 
          begin
            h_cnt <= 10'd0;
            hs_high <= h_cnt;
            scanline <= ~scanline;
          end
        else if (!hsD2 && hsD) 
          begin
            h_cnt <= 10'd0;
            hs_low <= h_cnt;
          end
        else h_cnt <= h_cnt+10'd1;
      end
  reg  [9:0] v_cnt;

  reg  vsD,vsD2;

  reg  [9:0] vs_low,vs_high;

  wire  vs_pol = vs_high < vs_low;

  wire [9:0]  v_dsp_width = vs_pol ? vs_low : vs_high;

  wire [9:0]  v_dsp_ctr = {1'b0,v_dsp_width[9:1]};

  
  always @(posedge hs_in)
      begin
        vsD <= vs_in;
        vsD2 <= vsD;
        if (!vsD && vsD2) 
          begin
            v_cnt <= 10'd0;
            vs_high <= v_cnt;
          end
        else if (!vsD2 && vsD) 
          begin
            v_cnt <= 10'd0;
            vs_low <= v_cnt;
          end
        else v_cnt <= v_cnt+10'd1;
      end
  wire [9:0] 
       h_osd_start = ((0-OSD_WIDTH>>1)+h_dsp_ctr)+OSD_X_OFFSET;

  wire [9:0] 
       h_osd_end = OSD_WIDTH>>1+((h_dsp_ctr+OSD_X_OFFSET)+(0-1));

  wire [9:0] 
       v_osd_start = OSD_Y_OFFSET+(v_dsp_ctr+(0-OSD_HEIGHT>>1));

  wire [9:0] 
       v_osd_end = ((0-1)+OSD_Y_OFFSET)+(OSD_HEIGHT>>1+v_dsp_ctr);

  reg  h_osd_active,v_osd_active;

  
  always @(posedge pclk)
      begin
        if (hs_in != hs_pol) 
          begin
            if (h_cnt == h_osd_start) h_osd_active <= 1'b1;
              
            if (h_cnt == h_osd_end) h_osd_active <= 1'b0;
              
          end
          
        if (vs_in != vs_pol) 
          begin
            if (v_cnt == v_osd_start) v_osd_active <= 1'b1;
              
            if (v_cnt == v_osd_end) v_osd_active <= 1'b0;
              
          end
          
      end
  wire 
       osd_de = v_osd_active && osd_enable && h_osd_active;

  wire [7:0]  osd_hcnt = h_cnt+(7'd1+(0-h_osd_start));

  wire [6:0]  osd_vcnt = (0-v_osd_start)+v_cnt;

  wire  osd_pixel = osd_byte[osd_vcnt[3:1]];

  reg  [7:0] osd_byte;

  
  always @(posedge pclk)
      osd_byte <= osd_buffer[{osd_vcnt[6:4],osd_hcnt}];
  wire [1<<1:0]  osd_color = OSD_COLOR;

  wire [5:0] 
       red_t = (scanline && scanline_ena_h) ? {1'b0,red_in[5:1]} : red_in;

  wire [5:0] 
       green_t = (scanline && scanline_ena_h) ? {1'b0,green_in[5:1]} : green_in;

  wire [5:0] 
       blue_t = (scanline && scanline_ena_h) ? {1'b0,blue_in[5:1]} : blue_in;

  assign red_out = !osd_de ? red_t : {osd_pixel,osd_pixel,osd_color[1<<1],red_t[5:3]};
  assign green_out = !osd_de ? green_t : {osd_pixel,osd_pixel,osd_color[1],green_t[5:3]};
  assign blue_out = !osd_de ? blue_t : {osd_pixel,osd_pixel,osd_color[0],blue_t[5:3]};
  assign hs_out = hs_in;
  assign vs_out = vs_in;
endmodule

