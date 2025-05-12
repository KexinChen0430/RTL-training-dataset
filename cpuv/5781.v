module sky130_fd_sc_lp__isolatch (
    Q      ,
    D      ,
    SLEEP_B
);
    output Q      ;
    input  D      ;
    input  SLEEP_B;
    supply1 KAPWR;
    supply1 VPWR ;
    supply0 VGND ;
    supply1 VPB  ;
    supply0 VNB  ;
endmodule