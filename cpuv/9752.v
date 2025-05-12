module sky130_fd_sc_lp__srsdfxtp (
    input  D      ,
    output Q      ,
    input  SCD    ,
    input  SCE    ,
    input  CLK    ,
    input  SLEEP_B
);
    supply1 KAPWR;
    supply1 VPWR ;
    supply0 VGND ;
    supply1 VPB  ;
    supply0 VNB  ;
endmodule