module outputs
  wire [63 : 0] mav_write, mv_read;
  reg rg_meip;
  wire rg_meip$D_IN, rg_meip$EN;
  reg rg_msip;
  wire rg_msip$D_IN, rg_msip$EN;
  reg rg_mtip;
  wire rg_mtip$D_IN, rg_mtip$EN;
  reg rg_seip;
  wire rg_seip$D_IN, rg_seip$EN;
  reg rg_ssip;
  wire rg_ssip$D_IN, rg_ssip$EN;
  reg rg_stip;
  wire rg_stip$D_IN, rg_stip$EN;
  reg rg_ueip;
  wire rg_ueip$D_IN, rg_ueip$EN;
  reg rg_usip;
  wire rg_usip$D_IN, rg_usip$EN;
  reg rg_utip;
  wire rg_utip$D_IN, rg_utip$EN;
  wire CAN_FIRE_m_external_interrupt_req,
       CAN_FIRE_mav_write,
       CAN_FIRE_reset,
       CAN_FIRE_s_external_interrupt_req,
       CAN_FIRE_software_interrupt_req,
       CAN_FIRE_timer_interrupt_req,
       WILL_FIRE_m_external_interrupt_req,
       WILL_FIRE_mav_write,
       WILL_FIRE_reset,
       WILL_FIRE_s_external_interrupt_req,
       WILL_FIRE_software_interrupt_req,
       WILL_FIRE_timer_interrupt_req;
  wire [11 : 0] new_mip__h524, new_mip__h942;
  wire seip__h558, ssip__h562, stip__h560, ueip__h559, usip__h563, utip__h561;
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;
  assign mv_read = { 52'd0, new_mip__h524 } ;
  assign mav_write = { 52'd0, new_mip__h942 } ;
  assign CAN_FIRE_mav_write = 1'd1 ;
  assign WILL_FIRE_mav_write = EN_mav_write ;
  assign CAN_FIRE_m_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_m_external_interrupt_req = 1'd1 ;
  assign CAN_FIRE_s_external_interrupt_req = 1'd1 ;
  assign WILL_FIRE_s_external_interrupt_req = 1'd1 ;
  assign CAN_FIRE_software_interrupt_req = 1'd1 ;
  assign WILL_FIRE_software_interrupt_req = 1'd1 ;
  assign CAN_FIRE_timer_interrupt_req = 1'd1 ;
  assign WILL_FIRE_timer_interrupt_req = 1'd1 ;
  assign rg_meip$D_IN = m_external_interrupt_req_req ;
  assign rg_meip$EN = 1'b1 ;
  assign rg_msip$D_IN = software_interrupt_req_req ;
  assign rg_msip$EN = 1'b1 ;
  assign rg_mtip$D_IN = timer_interrupt_req_req ;
  assign rg_mtip$EN = 1'b1 ;
  assign rg_seip$D_IN = s_external_interrupt_req_req ;
  assign rg_seip$EN = 1'b1 ;
  assign rg_ssip$D_IN = !EN_reset && ssip__h562 ;
  assign rg_ssip$EN = EN_mav_write || EN_reset ;
  assign rg_stip$D_IN = !EN_reset && stip__h560 ;
  assign rg_stip$EN = EN_mav_write || EN_reset ;
  assign rg_ueip$D_IN = !EN_reset && ueip__h559 ;
  assign rg_ueip$EN = EN_mav_write || EN_reset ;
  assign rg_usip$D_IN = !EN_reset && usip__h563 ;
  assign rg_usip$EN = EN_mav_write || EN_reset ;
  assign rg_utip$D_IN = !EN_reset && utip__h561 ;
  assign rg_utip$EN = EN_mav_write || EN_reset ;
  assign new_mip__h524 =
	     { rg_meip,
	       1'b0,
	       rg_seip,
	       rg_ueip,
	       rg_mtip,
	       1'b0,
	       rg_stip,
	       rg_utip,
	       rg_msip,
	       1'b0,
	       rg_ssip,
	       rg_usip } ;
  assign new_mip__h942 =
	     { rg_meip,
	       1'b0,
	       seip__h558,
	       ueip__h559,
	       rg_mtip,
	       1'b0,
	       stip__h560,
	       utip__h561,
	       rg_msip,
	       1'b0,
	       ssip__h562,
	       usip__h563 } ;
  assign seip__h558 = mav_write_misa[18] && mav_write_wordxl[9] ;
  assign ssip__h562 = mav_write_misa[18] && mav_write_wordxl[1] ;
  assign stip__h560 = mav_write_misa[18] && mav_write_wordxl[5] ;
  assign ueip__h559 = mav_write_misa[13] && mav_write_wordxl[8] ;
  assign usip__h563 = mav_write_misa[13] && mav_write_wordxl[0] ;
  assign utip__h561 = mav_write_misa[13] && mav_write_wordxl[4] ;
  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        rg_meip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_msip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_mtip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_seip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_ssip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_stip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_ueip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_usip <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_utip <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (rg_meip$EN) rg_meip <= `BSV_ASSIGNMENT_DELAY rg_meip$D_IN;
	if (rg_msip$EN) rg_msip <= `BSV_ASSIGNMENT_DELAY rg_msip$D_IN;
	if (rg_mtip$EN) rg_mtip <= `BSV_ASSIGNMENT_DELAY rg_mtip$D_IN;
	if (rg_seip$EN) rg_seip <= `BSV_ASSIGNMENT_DELAY rg_seip$D_IN;
	if (rg_ssip$EN) rg_ssip <= `BSV_ASSIGNMENT_DELAY rg_ssip$D_IN;
	if (rg_stip$EN) rg_stip <= `BSV_ASSIGNMENT_DELAY rg_stip$D_IN;
	if (rg_ueip$EN) rg_ueip <= `BSV_ASSIGNMENT_DELAY rg_ueip$D_IN;
	if (rg_usip$EN) rg_usip <= `BSV_ASSIGNMENT_DELAY rg_usip$D_IN;
	if (rg_utip$EN) rg_utip <= `BSV_ASSIGNMENT_DELAY rg_utip$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    rg_meip = 1'h0;
    rg_msip = 1'h0;
    rg_mtip = 1'h0;
    rg_seip = 1'h0;
    rg_ssip = 1'h0;
    rg_stip = 1'h0;
    rg_ueip = 1'h0;
    rg_usip = 1'h0;
    rg_utip = 1'h0;
  end
  `endif 
endmodule