module sky130_fd_sc_hs__sdfbbn (
    Q      ,     
    Q_N    ,     
    D      ,     
    SCD    ,     
    SCE    ,     
    CLK_N  ,     
    SET_B  ,     
    RESET_B       
);
    output Q      ; 
    output Q_N    ; 
    input  D      ; 
    input  SCD    ; 
    input  SCE    ; 
    input  CLK_N  ; 
    input  SET_B  ; 
    input  RESET_B; 
    supply1 VPWR; 
    supply0 VGND; 
endmodule 