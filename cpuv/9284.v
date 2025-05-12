module pll (CLKI, CLKOP, CLKOS, CLKOS2, CLKOS3);
    input wire CLKI; 
    output wire CLKOP; 
    output wire CLKOS; 
    output wire CLKOS2; 
    output wire CLKOS3; 
    wire LOCK;
    wire CLKOS3_t;
    wire CLKOS2_t;
    wire CLKOS_t;
    wire CLKOP_t;
    wire scuba_vlo;
    VLO scuba_vlo_inst (.Z(scuba_vlo)); 
    defparam PLLInst_0.DDRST_ENA = "DISABLED" ;
    EHXPLLJ PLLInst_0 (.CLKI(CLKI), .CLKFB(CLKOP_t), .PHASESEL1(scuba_vlo),
    assign CLKOS3 = CLKOS3_t; 
    assign CLKOS2 = CLKOS2_t; 
    assign CLKOS = CLKOS_t; 
    assign CLKOP = CLKOP_t; 
endmodule 