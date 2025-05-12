module system_pll (CLKI, CLKOP, CLKOS); 
    input wire CLKI; 
    output wire CLKOP; 
    output wire CLKOS; 
    wire LOCK; 
    wire CLKOS_t; 
    wire CLKOP_t; 
    wire scuba_vlo; 
    VLO scuba_vlo_inst (.Z(scuba_vlo)); 
    EHXPLLJ PLLInst_0 (.CLKI(CLKI), .CLKFB(CLKOP_t), .PHASESEL1(scuba_vlo),
        .PHASESEL0(scuba_vlo), .PHASEDIR(scuba_vlo), .PHASESTEP(scuba_vlo),
        .LOADREG(scuba_vlo), .STDBY(scuba_vlo), .PLLWAKESYNC(scuba_vlo),
        .RST(scuba_vlo), .RESETM(scuba_vlo), .RESETC(scuba_vlo), .RESETD(scuba_vlo),
        .ENCLKOP(scuba_vlo), .ENCLKOS(scuba_vlo), .ENCLKOS2(scuba_vlo),
        .ENCLKOS3(scuba_vlo), .PLLCLK(scuba_vlo), .PLLRST(scuba_vlo), .PLLSTB(scuba_vlo),
        .PLLWE(scuba_vlo), .PLLADDR4(scuba_vlo), .PLLADDR3(scuba_vlo), .PLLADDR2(scuba_vlo),
        .PLLADDR1(scuba_vlo), .PLLADDR0(scuba_vlo), .PLLDATI7(scuba_vlo),
        .PLLDATI6(scuba_vlo), .PLLDATI5(scuba_vlo), .PLLDATI4(scuba_vlo),
        .PLLDATI3(scuba_vlo), .PLLDATI2(scuba_vlo), .PLLDATI1(scuba_vlo),
        .PLLDATI0(scuba_vlo), .CLKOP(CLKOP_t), .CLKOS(CLKOS_t), .CLKOS2(),
        .CLKOS3(), .LOCK(LOCK), .INTLOCK(), .REFCLK(), .CLKINTFB(), .DPHSRC(),
        .PLLACK(), .PLLDATO7(), .PLLDATO6(), .PLLDATO5(), .PLLDATO4(), .PLLDATO3(),
        .PLLDATO2(), .PLLDATO1(), .PLLDATO0())
             ; 
    assign CLKOS = CLKOS_t; 
    assign CLKOP = CLKOP_t; 
endmodule