module sky130_fd_sc_hd__dlrtp (
    Q      ,     
    RESET_B,     
    D      ,     
    GATE        
);
    output Q      ; 
    input  RESET_B; 
    input  D      ; 
    input  GATE   ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 