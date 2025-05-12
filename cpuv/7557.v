module axi_tft_v2_0_h_sync(
    Clk,                    
    Rst,                    
    HSYNC,                  
    H_DE,                   
    VSYNC_Rst,              
    H_bp_cnt_tc,            
    H_bp_cnt_tc2,           
    H_pix_cnt_tc,           
    H_pix_cnt_tc2           
);
    input         Clk;
    input         Rst;
    output        VSYNC_Rst;
    output        HSYNC;
    output        H_DE;
    output        H_bp_cnt_tc;
    output        H_bp_cnt_tc2;
    output        H_pix_cnt_tc;
    output        H_pix_cnt_tc2;
    reg           VSYNC_Rst;
    reg           HSYNC;
    reg           H_DE;
    reg [0:6]     h_p_cnt;    
    reg [0:5]     h_bp_cnt;   
    reg [0:10]    h_pix_cnt;  
    reg [0:3]     h_fp_cnt;  
    reg           h_p_cnt_clr;
    reg           h_bp_cnt_clr;
    reg           h_pix_cnt_clr;
    reg           h_fp_cnt_clr;
    reg           h_p_cnt_tc;
    reg           H_bp_cnt_tc;
    reg           H_bp_cnt_tc2;
    reg           H_pix_cnt_tc;
    reg           H_pix_cnt_tc2;
    reg           h_fp_cnt_tc;
    parameter [0:4] SET_COUNTERS = 5'b00001;
    parameter [0:4] PULSE        = 5'b00010;
    parameter [0:4] BACK_PORCH   = 5'b00100;
    parameter [0:4] PIXEL        = 5'b01000;
    parameter [0:4] FRONT_PORCH  = 5'b10000;
    reg [0:4]       HSYNC_cs;
    reg [0:4]       HSYNC_ns;
    always @(posedge Clk)
    begin : HSYNC_REG_STATE
      if (Rst)
        begin
          HSYNC_cs  <= SET_COUNTERS;
          VSYNC_Rst <= 1;
        end
      else
        begin
          HSYNC_cs  <= HSYNC_ns;
          VSYNC_Rst <= 0;
        end
    end
    always @(HSYNC_cs or h_p_cnt_tc or H_bp_cnt_tc or H_pix_cnt_tc
             or h_fp_cnt_tc)
    begin : HSYNC_SM_CMB
       case (HSYNC_cs)
         SET_COUNTERS: begin
           h_p_cnt_clr   = 1;
           h_bp_cnt_clr  = 1;
           h_pix_cnt_clr = 1;
           h_fp_cnt_clr  = 1;
           HSYNC         = 1;
           H_DE          = 0;
           HSYNC_ns      = PULSE;
         end
         PULSE: begin
           h_p_cnt_clr   = 0;
           h_bp_cnt_clr  = 1;
           h_pix_cnt_clr = 1;
           h_fp_cnt_clr  = 1;
           HSYNC         = 0;
           H_DE          = 0;
           if (h_p_cnt_tc == 0)
             HSYNC_ns = PULSE;
           else
             HSYNC_ns = BACK_PORCH;
         end
         BACK_PORCH: begin
           h_p_cnt_clr   = 1;
           h_bp_cnt_clr  = 0;
           h_pix_cnt_clr = 1;
           h_fp_cnt_clr  = 1;
           HSYNC         = 1;
           H_DE          = 0;
           if (H_bp_cnt_tc == 0)
             HSYNC_ns = BACK_PORCH;
           else
             HSYNC_ns = PIXEL;
         end
         PIXEL: begin
           h_p_cnt_clr   = 1;
           h_bp_cnt_clr  = 1;
           h_pix_cnt_clr = 0;
           h_fp_cnt_clr  = 1;
           HSYNC         = 1;
           H_DE          = 1;
           if (H_pix_cnt_tc == 0)
             HSYNC_ns = PIXEL;
           else
             HSYNC_ns = FRONT_PORCH;
         end
         FRONT_PORCH: begin
           h_p_cnt_clr   = 1;
           h_bp_cnt_clr  = 1;
           h_pix_cnt_clr = 1;
           h_fp_cnt_clr  = 0;
           HSYNC         = 1;
           H_DE          = 0;
           if (h_fp_cnt_tc == 0)
             HSYNC_ns = FRONT_PORCH;
           else
             HSYNC_ns = PULSE;
         end
         default: begin
           h_p_cnt_clr   = 1;
           h_bp_cnt_clr  = 1;
           h_pix_cnt_clr = 1;
           h_fp_cnt_clr  = 0;
           HSYNC         = 1;
           H_DE          = 0;
           HSYNC_ns      = SET_COUNTERS;
         end
       endcase
    end
    always @(posedge Clk)
    begin : HSYNC_PULSE_CNT
      if (Rst || h_p_cnt_clr)
        begin
          h_p_cnt <= 7'b0;
          h_p_cnt_tc <= 0;
        end
      else
        begin
          if (h_p_cnt == 94)
            begin
              h_p_cnt <= h_p_cnt + 1;
              h_p_cnt_tc <= 1;
            end
          else
            begin
              h_p_cnt <= h_p_cnt + 1;
              h_p_cnt_tc <= 0;
            end
        end
    end
    always @(posedge Clk )
    begin : HSYNC_BP_CNTR
      if (Rst || h_bp_cnt_clr)
        begin
          h_bp_cnt <= 6'b0;
          H_bp_cnt_tc <= 0;
          H_bp_cnt_tc2 <= 0;
        end
      else
        begin
          if (h_bp_cnt == 45)
            begin
              h_bp_cnt <= h_bp_cnt + 1;
              H_bp_cnt_tc2 <= 1;
              H_bp_cnt_tc <= 0;
            end
          else if (h_bp_cnt == 46)
            begin
              h_bp_cnt <= h_bp_cnt + 1;
              H_bp_cnt_tc <= 1;
              H_bp_cnt_tc2 <= 0;
            end
          else
            begin
              h_bp_cnt <= h_bp_cnt + 1;
              H_bp_cnt_tc <= 0;
              H_bp_cnt_tc2 <= 0;
            end
        end
    end
    always @(posedge Clk)
    begin : HSYNC_PIX_CNTR
        if (Rst || h_pix_cnt_clr)
          begin
            h_pix_cnt <= 11'b0;
            H_pix_cnt_tc <= 0;
            H_pix_cnt_tc2 <= 0;
          end
        else
          begin
            if (h_pix_cnt == 637)
              begin
                h_pix_cnt <= h_pix_cnt + 1;
                H_pix_cnt_tc2 <= 1;
              end
            else if (h_pix_cnt == 638)
              begin
                h_pix_cnt <= h_pix_cnt + 1;
                H_pix_cnt_tc <= 1;
              end
            else
              begin
                h_pix_cnt <= h_pix_cnt + 1;
                H_pix_cnt_tc <= 0;
                H_pix_cnt_tc2 <= 0;
              end
            end
    end
    always @(posedge Clk)
    begin : HSYNC_FP_CNTR
        if (Rst || h_fp_cnt_clr)
            begin
            h_fp_cnt <= 5'b0;
            h_fp_cnt_tc <= 0;
            end
        else
            begin
                if (h_fp_cnt == 14)
                    begin
                    h_fp_cnt <= h_fp_cnt + 1;
                    h_fp_cnt_tc <= 1;
                    end
                else
                    begin
                    h_fp_cnt <= h_fp_cnt + 1;
                    h_fp_cnt_tc <= 0;
                    end
            end
    end
endmodule