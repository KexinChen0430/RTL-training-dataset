
module axi_tft_v2_0_v_sync(Clk,Clk_stb,Rst,VSYNC,V_DE,V_bp_cnt_tc,V_p_cnt_tc,V_l_cnt_tc);

  input  Clk;
  input  Clk_stb;
  input  Rst;
  output VSYNC;
  output V_DE;
  output V_bp_cnt_tc;
  output V_p_cnt_tc;
  output V_l_cnt_tc;
  reg  V_DE;
  reg  VSYNC;
  reg  [0:1] v_p_cnt;
  reg  [0:4] v_bp_cnt;
  reg  [0:8] v_l_cnt;
  reg  [0:3] v_fp_cnt;
  reg  v_p_cnt_clr;
  reg  v_bp_cnt_clr;
  reg  v_l_cnt_clr;
  reg  v_fp_cnt_clr;
  reg  V_p_cnt_tc;
  reg  V_bp_cnt_tc;
  reg  V_l_cnt_tc;
  reg  v_fp_cnt_tc;
  parameter [0:4]  SET_COUNTERS = 5'b00001;
  parameter [0:4]  PULSE = 5'b00010;
  parameter [0:4]  BACK_PORCH = 5'b00100;
  parameter [0:4]  LINE = 5'b01000;
  parameter [0:4]  FRONT_PORCH = 5'b10000;
  reg  [0:4] VSYNC_cs;
  reg  [0:4] VSYNC_ns;
  reg  clk_stb_d1;
  reg  clk_ce_neg;
  reg  clk_ce_pos;

  
  always @(posedge Clk)
      begin : CLOCK_STRB_GEN
        clk_stb_d1 <= Clk_stb;
        clk_ce_pos <= ~clk_stb_d1 & Clk_stb;
        clk_ce_neg <= ~Clk_stb & clk_stb_d1;
      end
  
  always @(posedge Clk)
      begin : VSYNC_REG_STATE
        if (Rst) VSYNC_cs <= SET_COUNTERS;
        else if (clk_ce_pos) VSYNC_cs <= VSYNC_ns;
          
      end
  
  always @(VSYNC_cs or V_p_cnt_tc or V_bp_cnt_tc or V_l_cnt_tc or v_fp_cnt_tc)
      begin : VSYNC_SM_CMB
        case (VSYNC_cs)

          SET_COUNTERS: begin
                v_p_cnt_clr = 1;
                v_bp_cnt_clr = 1;
                v_l_cnt_clr = 1;
                v_fp_cnt_clr = 1;
                VSYNC = 1;
                V_DE = 0;
                VSYNC_ns = PULSE;
              end

          PULSE: begin
                v_p_cnt_clr = 0;
                v_bp_cnt_clr = 1;
                v_l_cnt_clr = 1;
                v_fp_cnt_clr = 1;
                VSYNC = 0;
                V_DE = 0;
                if (V_p_cnt_tc == 0) VSYNC_ns = PULSE;
                else VSYNC_ns = BACK_PORCH;
              end

          BACK_PORCH: begin
                v_p_cnt_clr = 1;
                v_bp_cnt_clr = 0;
                v_l_cnt_clr = 1;
                v_fp_cnt_clr = 1;
                VSYNC = 1;
                V_DE = 0;
                if (V_bp_cnt_tc == 0) VSYNC_ns = BACK_PORCH;
                else VSYNC_ns = LINE;
              end

          LINE: begin
                v_p_cnt_clr = 1;
                v_bp_cnt_clr = 1;
                v_l_cnt_clr = 0;
                v_fp_cnt_clr = 1;
                VSYNC = 1;
                V_DE = 1;
                if (V_l_cnt_tc == 0) VSYNC_ns = LINE;
                else VSYNC_ns = FRONT_PORCH;
              end

          FRONT_PORCH: begin
                v_p_cnt_clr = 1;
                v_bp_cnt_clr = 1;
                v_l_cnt_clr = 1;
                v_fp_cnt_clr = 0;
                VSYNC = 1;
                V_DE = 0;
                if (v_fp_cnt_tc == 0) VSYNC_ns = FRONT_PORCH;
                else VSYNC_ns = PULSE;
              end

          default: begin
                v_p_cnt_clr = 1;
                v_bp_cnt_clr = 1;
                v_l_cnt_clr = 1;
                v_fp_cnt_clr = 0;
                VSYNC = 1;
                V_DE = 0;
                VSYNC_ns = SET_COUNTERS;
              end

        endcase

      end
  
  always @(posedge Clk)
      begin : VSYNC_PULSE_CNTR
        if (v_p_cnt_clr || Rst) 
          begin
            v_p_cnt <= 2'b0;
            V_p_cnt_tc <= 0;
          end
        else if (clk_ce_neg) 
          begin
            if (v_p_cnt == 1) 
              begin
                v_p_cnt <= 1+v_p_cnt;
                V_p_cnt_tc <= 1;
              end
            else 
              begin
                v_p_cnt <= 1+v_p_cnt;
                V_p_cnt_tc <= 0;
              end
          end
          
      end
  
  always @(posedge Clk)
      begin : VSYNC_BP_CNTR
        if (v_bp_cnt_clr || Rst) 
          begin
            v_bp_cnt <= 5'b0;
            V_bp_cnt_tc <= 0;
          end
        else if (clk_ce_neg) 
          begin
            if (v_bp_cnt == 30) 
              begin
                v_bp_cnt <= v_bp_cnt+1;
                V_bp_cnt_tc <= 1;
              end
            else 
              begin
                v_bp_cnt <= v_bp_cnt+1;
                V_bp_cnt_tc <= 0;
              end
          end
          
      end
  
  always @(posedge Clk)
      begin : VSYNC_LINE_CNTR
        if (Rst || v_l_cnt_clr) 
          begin
            v_l_cnt <= 9'b0;
            V_l_cnt_tc <= 0;
          end
        else if (clk_ce_neg) 
          begin
            if (v_l_cnt == 479) 
              begin
                v_l_cnt <= 1+v_l_cnt;
                V_l_cnt_tc <= 1;
              end
            else 
              begin
                v_l_cnt <= 1+v_l_cnt;
                V_l_cnt_tc <= 0;
              end
          end
          
      end
  
  always @(posedge Clk)
      begin : VSYNC_FP_CNTR
        if (Rst || v_fp_cnt_clr) 
          begin
            v_fp_cnt <= 4'b0;
            v_fp_cnt_tc <= 0;
          end
        else if (clk_ce_neg) 
          begin
            if (v_fp_cnt == 11) 
              begin
                v_fp_cnt <= 1+v_fp_cnt;
                v_fp_cnt_tc <= 1;
              end
            else 
              begin
                v_fp_cnt <= 1+v_fp_cnt;
                v_fp_cnt_tc <= 0;
              end
          end
          
      end
endmodule

