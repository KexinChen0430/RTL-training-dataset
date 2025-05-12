module sky130_fd_sc_hdll__inputiso1p (
    X    ,  
    A    ,  
    SLEEP   
);
    output X;
    input  A;
    input  SLEEP;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB;
    supply0 VNB;
endmodule