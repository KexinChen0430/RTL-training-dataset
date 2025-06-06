module sky130_fd_sc_hd__dlxbn ( 
    Q     , 
    Q_N   , 
    D     , 
    GATE_N 
);
    output Q     ; 
    output Q_N   ; 
    input  D     ; 
    input  GATE_N; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 