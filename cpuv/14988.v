module.
  assign c_crt_line_end = (txt_crt_line_end | c_pre_vde | ~sync_soft1) & en_req;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n) begin 
      sync_soft0 <= 1'b0; 
      sync_soft1 <= 1'b0; 
      vga_en0    <= 1'b0; 
      en_req     <= 1'b0; 
    end else begin 
      sync_soft0 <= m_soft_rst_n; 
      sync_soft1 <= sync_soft0;   
      vga_en0    <= vga_en;       
      en_req     <= vga_en0;      
    end
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n) vdisp_end_ff <= 1'b0; 
    else if (lclk_or_by_2) vdisp_end_ff <= vde_ff; 
  assign int_vdisp_end = ~(vde_ff | (~vdisp_end_ff));
  assign c_vdisp_end = int_vdisp_end & int_crt_line_end;
  assign vblank_eq_s_or_e = vblank_ff ? (~vblank_e_eq) : vblank_s_eq;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n) vblank_ff <= 1'b0; 
    else if (lclk_or_by_2) vblank_ff <= vblank_eq_s_or_e; 
  assign c_vert_blank = vblank_ff;
  assign vsync_eq_s_or_e = vsync_ff ? (~vsync_e_eq) : vsync_s_eq;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n) vsync_ff <= 1'b0; 
    else if (lclk_or_by_2) vsync_ff <= vsync_eq_s_or_e; 
  assign raw_vsync = vsync_ff;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      raw_vsync_ff <= 1'b0; 
    else
      raw_vsync_ff <= raw_vsync; 
  assign c_raw_vsync = raw_vsync_ff;
  assign int_vsync = (raw_vsync & vsync_en) ^ vsync_pol;
  assign int_vsync2 = int_vsync;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      syn_vsync_ff <= 1'b0; 
    else
      syn_vsync_ff <= int_vsync2; 
  assign c_t_vsync = syn_vsync_ff;
  assign lncmp_eq_ff_din = ((lncmp_eq_ff | lncmp_eq_raw) & vde_ff);
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      lncmp_eq_ff <=  1'b0; 
    else if (cclk_en)
      lncmp_eq_ff <= lncmp_eq_ff_din; 
  assign int_split_screen_pulse = c_split_screen_pulse;
  assign split_screen_pulse = ((c_pre_vde & lncmp_zero) | ((~lncmp_zero) & int_split_screen_pulse));
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      sync_ssp_ff <= 1'b0; 
    else if(int_crt_line_end & cclk_en)
      sync_ssp_ff <= lncmp_eq_ff; 
  assign c_split_screen_pulse = lncmp_eq_ff & (~sync_ssp_ff);
  assign split_screen_zero = lncmp_zero | lncmp_eq_ff;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      line_cmp_ff <=  1'b0; 
    else if (cclk_en) begin
      if(split_screen_zero & vde_ff)
        line_cmp_ff <=  1'b1; 
      else if(~vde_ff)
        line_cmp_ff <=  1'b0; 
    end
  assign line_cmp = line_cmp_ff;
  assign c_pre_vde = vt_eq_d & int_crt_line_end;
  assign byte_pan_en = c_pre_vde;
  assign pel_pan_en = c_pre_vde;
  assign vsync_vde = vsync_sel_ctl ? (c_t_vsync | c_vde) : c_t_vsync;
endmodule