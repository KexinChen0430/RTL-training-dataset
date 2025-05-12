module sky130_fd_sc_ls__dlclkp ( 
    GCLK, 
    GATE, 
    CLK   
);
    output GCLK; 
    input  GATE; 
    input  CLK ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 