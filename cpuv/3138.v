module sky130_fd_sc_hd__sdlclkp (
    GCLK, 
    SCE,  
    GATE, 
    CLK   
);
    output GCLK; 
    input  SCE;  
    input  GATE; 
    input  CLK;  
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB;  
    supply0 VNB;  
endmodule