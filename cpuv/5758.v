module sky130_fd_sc_hdll__nor2b (
    Y  ,
    A  ,
    B_N
);
    output Y  ;
    input  A  ;
    input  B_N;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule