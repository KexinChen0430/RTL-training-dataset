module <ModuleName> (
);
    always @(posedge cpu_clock)
    begin
        if( memreg_rd )
        begin
            snd_wrtoggle <= ~snd_wrtoggle; 
            snd_datnvol  <= 1'b1; 
            if( !mode_8chans )
                snd_addr <= { 1'b0, a[9:8] };
            else 
                snd_addr <= a[10:8];
            snd_data <= din; 
        end
        else if( volports_enabled && port_wr )
        begin
            snd_wrtoggle <= ~snd_wrtoggle; 
            snd_datnvol  <= 1'b0; 
            snd_addr <= volnum; 
            snd_data <= din; 
        end
    end
    assign sd_din = (a[5:0]==SD_RSTR) ? 8'hFF : din; 
    assign mc_din = din; 
    assign md_din = din; 
    assign sd_start = p_sdsnd_wr | p_sdrst_rd; 
    assign mc_start = p_mcsnd_wr; 
    assign md_start = p_mdsnd_wr; 
    always @(posedge cpu_clock, negedge rst_n)
    begin
        if( !rst_n ) 
        begin
            md_halfspeed <= 1'b0;
            mc_halfspeed <= 1'b1;
            mc_xrst      <= 1'b0;
            mc_ncs       <= 1'b1;
            sd_ncs       <= 1'b1;
        end
        else 
        begin
            if( p_sctrl_wr )
            begin
                if( din[0] ) sd_ncs       <= din[7]; 
                if( din[1] ) mc_ncs       <= din[7]; 
                if( din[2] ) mc_xrst      <= din[7]; 
                if( din[3] ) mc_halfspeed <= din[7]; 
                if( din[4] ) md_halfspeed <= din[7]; 
            end
        end
    end
    always @(posedge cpu_clock, negedge rst_n)
    begin
        if( !rst_n ) 
        begin
            led <= 1'b0; 
        end
        else 
        begin
            if( p_ledctr_wr )
                led <= din[0];
            else if( led_toggle ) 
                led <= ~led; 
        end
    end
endmodule 