module 
assign sd_datain = sddat_rd ? 8'hFF : din;
always @(posedge fclk)
	if( sd_start )
		sd_rd_buffer <= sd_dataout;
wire atm77_wr_fclk;
wire zxevbf_wr_fclk;
assign atmF7_wr_fclk = ( (loa==ATMF7) && (a[8]==1'b1) && shadow && port_wr_fclk );
assign atm77_wr_fclk = ( (loa==ATM77) && shadow && port_wr_fclk );
assign zxevbf_wr_fclk = ( (loa==ZXEVBF) && port_wr_fclk );
always @(posedge fclk, negedge rst_n)
	if( !rst_n )
	begin
		shadow_en_reg <= 1'b0;
		romrw_en_reg  <= 1'b0;
		fntw_en_reg   <= 1'b0;
		set_nmi       <= 1'b0;
		brk_ena       <= 1'b0;
		pal444_ena    <= 1'b0;
	end
	else if( zxevbf_wr_fclk )
	begin
		shadow_en_reg <= din[0];
		romrw_en_reg  <= din[1];
		fntw_en_reg   <= din[2];
		set_nmi       <= din[3];
		brk_ena       <= din[4];
		pal444_ena    <= din[5];
	end
assign romrw_en = romrw_en_reg;
always @(posedge fclk, negedge rst_n)
	if( !rst_n )
	begin
		atm_scr_mode = 3'b011;
		atm_turbo    = 1'b0;
		atm_pen =   1'b1; 
		atm_cpm_n = 1'b0; 
		atm_pen2     = 1'b0;
	end
	else if( atm77_wr_fclk )
	begin
		atm_scr_mode <= din[2:0];
		atm_turbo    <= din[3];
		atm_pen      <= ~a[8];
		atm_cpm_n    <=  a[9];
		atm_pen2     <= ~a[14];
	end
assign vg_wrFF_fclk = ( ( (loa==VGSYS)&&shadow ) && port_wr_fclk);
assign atm_palwr = vg_wrFF_fclk & atm_pen2;
assign atm_paldata = { ~din[4], ~din[7], ~din[1], ~din[6], ~din[0], ~din[5] }; 
assign atm_paldatalow = { ~a[4+8], ~a[7+8], ~a[1+8], ~a[6+8], ~a[0+8], ~a[5+8] }; 
always @(posedge fclk, negedge rst_n)
	if( !rst_n )
		vg_rdwr_fclk <= 1'b0;
	else
		vg_rdwr_fclk <= ((loa==VGCOM) ||
		                 (loa==VGTRK) ||
		                 (loa==VGSEC) ||
		                 (loa==VGDAT) ||
		                 (loa==VGSYS)  ) && shadow && (port_wr_fclk || port_rd_fclk);
assign clr_nmi = ( (loa==ZXEVBE) && port_wr_fclk );
assign beeper_wr = (loa==PORTFE) && portfe_wr_fclk;
assign covox_wr  = (loa==COVOX) && port_wr_fclk;
assign fnt_wr = fntw_en_reg && mem_wr_fclk;
always @*
	case( a[12:8] )
	BD_PG0: portbdmux = pages[ 7:0 ];
	BD_PG1: portbdmux = pages[15:8 ];
	BD_PG2: portbdmux = pages[23:16];
	BD_PG3: portbdmux = pages[31:24];
	BD_PG4: portbdmux = pages[39:32];
	BD_PG5: portbdmux = pages[47:40];
	BD_PG6: portbdmux = pages[55:48];
	BD_PG7: portbdmux = pages[63:56];
	BD_RAMNROMS: portbdmux = ramnroms;
	BD_DOS7FFDS: portbdmux = dos7ffds;
	BD_P7FFD: portbdmux = p7ffd_int;
	BD_PEFF7: portbdmux = peff7_int;
	BD_PXX77: portbdmux = { ~atm_pen2, atm_cpm_n, ~atm_pen, dos, atm_turbo, atm_scr_mode };
	BD_COLORRD: portbdmux = { ~palcolor[4], ~palcolor[2], ~palcolor[0], ~palcolor[5], 2'b11, ~palcolor[3], ~palcolor[1] };
	BD_FNTRD:    portbdmux = fontrom_readback;
	BD_BORDERRD: portbdmux = { 4'bXXXX, border };
	BD_LOBRK: portbdmux = brk_addr[7:0];
	BD_HIBRK: portbdmux = brk_addr[15:8];
	BD_WRDISRD: portbdmux = wrdisables;
	BD_FDDMASK: portbdmux = { 4'bXXXX, fdd_mask };
	default: portbdmux = 8'bXXXXXXXX;
	endcase
reg up_select;
wire up_wr = port_wr_fclk && (loa==ULAPLUS);
always @(posedge fclk)
	if( up_wr && !a[14] )
	begin
		if( !din[7] &&  din[6] )
		begin
			up_select <= 1'b1;
		end
		if( !din[7] && !din[6] )
		begin
			up_select <= 1'b0;
			up_paladdr[5:0] <= din[5:0];
		end
	end
always @(posedge fclk) if( up_wr && a[14] )
		up_lastwritten <= din;
assign up_palwr = up_wr && a[14] && !up_select;
always @(posedge fclk, negedge rst_n)
	if( !rst_n )
		up_ena <= 1'b0;
	else if( up_wr && a[14] && up_select )
		up_ena <= din[0];
assign up_paldata = {din[4:2],din[7:5],din[1:0]}; 
endmodule 