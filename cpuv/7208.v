module sky130_fd_sc_hdll__sdfrtn (
    Q      ,
    CLK_N  ,
    D      ,
    SCD    ,
    SCE    ,
    RESET_B
);
    output Q      ;
    input  CLK_N  ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  RESET_B;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule