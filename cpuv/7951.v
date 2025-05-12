module sky130_fd_sc_lp__dfrbp (
    Q      ,     
    Q_N    ,     
    CLK    ,     
    D      ,     
    RESET_B      
);
    output Q      ; 
    output Q_N    ; 
    input  CLK    ; 
    input  D      ; 
    input  RESET_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 