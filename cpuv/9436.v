module osd (
    input        clk_sys,
    input        SPI_SCK,
    input        SPI_SS3,
    input        SPI_DI,
    input  [5:0] R_in,
    input  [5:0] G_in,
    input  [5:0] B_in,
    input        HSync,
    input        VSync,
    output [5:0] R_out,
    output [5:0] G_out,
    output [5:0] B_out
);
parameter OSD_X_OFFSET = 10'd0;
parameter OSD_Y_OFFSET = 10'd0;
parameter OSD_COLOR    = 3'd0;
localparam OSD_WIDTH   = 10'd256;
localparam OSD_HEIGHT  = 10'd128;
reg        osd_enable;
(* ramstyle = "no_rw_check" *) reg  [7:0] osd_buffer[2047:0];  
always@(posedge SPI_SCK, posedge SPI_SS3) begin
    reg  [4:0] cnt;
    reg [10:0] bcnt;
    reg  [7:0] sbuf;
    reg  [7:0] cmd;
    if(SPI_SS3) begin
        cnt  <= 0;
        bcnt <= 0;
    end else begin
        sbuf <= {sbuf[6:0], SPI_DI};
        if(cnt < 15) cnt <= cnt + 1'd1;
        else cnt <= 8;
        if(cnt == 7) begin
            cmd <= {sbuf[6:0], SPI_DI};
            bcnt <= {sbuf[1:0], SPI_DI, 8'h00};
            if(sbuf[6:3] == 4'b0100) osd_enable <= SPI_DI;
        end
        if((cmd[7:3] == 5'b00100) && (cnt == 15)) begin
            osd_buffer[bcnt] <= {sbuf[6:0], SPI_DI};
            bcnt <= bcnt + 1'd1;
        end
    end
end
reg  [9:0] h_cnt;
reg  [9:0] hs_low, hs_high;
wire       hs_pol = hs_high < hs_low;
wire [9:0] dsp_width = hs_pol ? hs_low : hs_high;
reg  [9:0] v_cnt;
reg  [9:0] vs_low, vs_high;
wire       vs_pol = vs_high < vs_low;
wire [9:0] dsp_height = vs_pol ? vs_low : vs_high;
wire doublescan = (dsp_height>350);
reg ce_pix;
always @(negedge clk_sys) begin
    integer cnt = 0;
    integer pixsz, pixcnt;
    reg hs;
    cnt <= cnt + 1;
    hs <= HSync;
    pixcnt <= pixcnt + 1;
    if(pixcnt == pixsz) pixcnt <= 0;
    ce_pix <= !pixcnt;
    if(hs && ~HSync) begin
        cnt    <= 0;
        pixsz  <= (cnt >> 9) - 1;
        pixcnt <= 0;
        ce_pix <= 1;
    end
end
always @(posedge clk_sys) begin
    reg hsD, hsD2;
    reg vsD, vsD2;
    if(ce_pix) begin
        hsD <= HSync;
        hsD2 <= hsD;
        if(!hsD && hsD2) begin
            h_cnt <= 0;
            hs_high <= h_cnt;
        end
        else if(hsD && !hsD2) begin
            h_cnt <= 0;
            hs_low <= h_cnt;
            v_cnt <= v_cnt + 1'd1;
        end else begin
            h_cnt <= h_cnt + 1'd1;
        end
        vsD <= VSync;
        vsD2 <= vsD;
        if(!vsD && vsD2) begin
            v_cnt <= 0;
            vs_high <= v_cnt;
        end
        else if(vsD && !vsD2) begin
            v_cnt <= 0;
            vs_low <= v_cnt;
        end
    end
end
wire [9:0] h_osd_start = ((dsp_width - OSD_WIDTH)>> 1) + OSD_X_OFFSET;
wire [9:0] h_osd_end   = h_osd_start + OSD_WIDTH;
wire [9:0] v_osd_start = ((dsp_height- (OSD_HEIGHT<<doublescan))>> 1) + OSD_Y_OFFSET;
wire [9:0] v_osd_end   = v_osd_start + (OSD_HEIGHT<<doublescan);
wire [9:0] osd_hcnt    = h_cnt - h_osd_start + 1'd1;
wire [9:0] osd_vcnt    = v_cnt - v_osd_start;
wire osd_de = osd_enable &&
              (HSync != hs_pol) && (h_cnt >= h_osd_start) && (h_cnt < h_osd_end) &&
              (VSync != vs_pol) && (v_cnt >= v_osd_start) && (v_cnt < v_osd_end);
reg  [7:0] osd_byte;
always @(posedge clk_sys) if(ce_pix) osd_byte <= osd_buffer[{doublescan ? osd_vcnt[7:5] : osd_vcnt[6:4], osd_hcnt[7:0]}];
wire osd_pixel = osd_byte[doublescan ? osd_vcnt[4:2] : osd_vcnt[3:1]];
assign R_out = !osd_de ? R_in : {osd_pixel, osd_pixel, OSD_COLOR[2], R_in[5:3]};
assign G_out = !osd_de ? G_in : {osd_pixel, osd_pixel, OSD_COLOR[1], G_in[5:3]};
assign B_out = !osd_de ? B_in : {osd_pixel, osd_pixel, OSD_COLOR[0], B_in[5:3]};
endmodule