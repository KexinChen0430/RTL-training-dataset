module sky130_fd_sc_lp__lsbufiso1p (
    input  A    ,
    output X    ,
    input  SLEEP
);
    supply1 DESTPWR;
    supply1 VPWR   ;
    supply0 VGND   ;
    supply1 DESTVPB;
    supply1 VPB    ;
    supply0 VNB    ;
endmodule