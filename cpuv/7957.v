module sky130_fd_sc_hvl__sdlxtp (
    Q   ,
    D   ,
    SCD ,
    SCE ,
    GATE
);
    output Q   ;
    input  D   ;
    input  SCD ;
    input  SCE ;
    input  GATE;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule