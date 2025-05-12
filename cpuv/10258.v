module sky130_fd_sc_lp__busdrivernovlpsleep (
    Z    ,
    A    ,
    TE_B ,
    SLEEP
);
    output Z    ;
    input  A    ;
    input  TE_B ;
    input  SLEEP;
    supply1 VPWR ;
    supply0 VGND ;
    supply1 KAPWR;
    supply1 VPB  ;
    supply0 VNB  ;
endmodule