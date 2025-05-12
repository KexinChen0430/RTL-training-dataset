module
    assign sd_datain = sddat_rd ? 8'hFF : din;
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
    end
    else if( zxevbf_wr_fclk ) 
    begin
        shadow_en_reg <= din[0];
        romrw_en_reg  <= din[1];
        fntw_en_reg   <= din[2];
        set_nmi       <= din[3];
        brk_ena       <= din[4];
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
    wire vg_wrFF_fclk;
    assign vg_wrFF_fclk = ( ( (loa==VGSYS)&&shadow ) && port_wr_fclk);
    assign atm_palwr = vg_wrFF_fclk & atm_pen2;
    assign atm_paldata = { ~din[4], ~din[7], ~din[1], ~din[6], ~din[0], ~din[5] };
    assign clr_nmi = ( (loa==ZXEVBE) && port_wr_fclk );
    assign beeper_wr = (loa==PORTFE) && portfe_wr_fclk;
    assign covox_wr  = (loa==COVOX) && port_wr_fclk;
    assign fnt_wr = fntw_en_reg && mem_wr_fclk;
    always @*
    case( a[12:8] ) 
    5'h0: portbemux = pages[ 7:0 ];
    5'h1: portbemux = pages[15:8 ];
    5'h2: portbemux = pages[23:16];
    5'h3: portbemux = pages[31:24];
    5'h4: portbemux = pages[39:32];
    5'h5: portbemux = pages[47:40];
    5'h6: portbemux = pages[55:48];
    5'h7: portbemux = pages[63:56];
    5'h8: portbemux = ramnroms;
    5'h9: portbemux = dos7ffds;
    5'hA: portbemux = p7ffd_int;
    5'hB: portbemux = peff7_int;
    5'hC: portbemux = { ~atm_pen2, atm_cpm_n, ~atm_pen, dos, atm_turbo, atm_scr_mode };
    5'hD: portbemux = { ~palcolor[4], ~palcolor[2], ~palcolor[0], ~palcolor[5], 2'b11, ~palcolor[3], ~palcolor[1] };
    5'hE: portbemux = fontrom_readback;
    5'h10: portbemux = brk_addr[7:0];
    5'h11: portbemux = brk_addr[15:8];
    default: portbemux = 8'bXXXXXXXX; 
    endcase
    always @(posedge fclk)
    if( port_wr_fclk && shadow ) 
    begin
        if( (loa==SAVPORT1) ||
            (loa==SAVPORT2) ||
            (loa==SAVPORT3) ||
            (loa==SAVPORT4) )
            savport[ loa[6:5] ] <= din; 
    end
endmodule