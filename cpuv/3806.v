module outputs
  wire [63 : 0] mav_write, mv_read;
  reg [11 : 0] rg_mie;
  wire [11 : 0] rg_mie$D_IN;
  wire rg_mie$EN;
  wire CAN_FIRE_mav_write,
       CAN_FIRE_reset,
       WILL_FIRE_mav_write,
       WILL_FIRE_reset;
  wire [11 : 0] mie__h88;
  wire seie__h119, ssie__h113, stie__h116, ueie__h118, usie__h112, utie__h115;
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;
  assign mv_read = { 52'd0, rg_mie } ;
  assign mav_write = { 52'd0, mie__h88 } ;
  assign CAN_FIRE_mav_write = 1'd1 ;
  assign WILL_FIRE_mav_write = EN_mav_write ;
  assign rg_mie$D_IN = EN_mav_write ? mie__h88 : 12'd0 ;
  assign rg_mie$EN = EN_mav_write || EN_reset ;
  assign mie__h88 =
	     { mav_write_wordxl[11],
	       1'b0,
	       seie__h119,
	       ueie__h118,
	       mav_write_wordxl[7],
	       1'b0,
	       stie__h116,
	       utie__h115,
	       mav_write_wordxl[3],
	       1'b0,
	       ssie__h113,
	       usie__h112 } ;
  assign seie__h119 = mav_write_misa[18] && mav_write_wordxl[9] ;
  assign ssie__h113 = mav_write_misa[18] && mav_write_wordxl[1] ;
  assign stie__h116 = mav_write_misa[18] && mav_write_wordxl[5] ;
  assign ueie__h118 = mav_write_misa[13] && mav_write_wordxl[8] ;
  assign usie__h112 = mav_write_misa[13] && mav_write_wordxl[0] ;
  assign utie__h115 = mav_write_misa[13] && mav_write_wordxl[4] ;
  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        rg_mie <= `BSV_ASSIGNMENT_DELAY 12'd0;
      end
    else
      begin
        if (rg_mie$EN) rg_mie <= `BSV_ASSIGNMENT_DELAY rg_mie$D_IN;
      end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial
  begin
    rg_mie = 12'hAAA;
  end
  `endif 
endmodule