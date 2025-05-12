module sky130_fd_sc_hs__sdfrtp ( 
    RESET_B,                     
    CLK    ,                     
    D      ,                     
    Q      ,                     
    SCD    ,                     
    SCE                           
);
    input  RESET_B;              
    input  CLK    ;              
    input  D      ;              
    output Q      ;              
    input  SCD    ;              
    input  SCE    ;              
    supply1 VPWR;                
    supply0 VGND;                
endmodule                       