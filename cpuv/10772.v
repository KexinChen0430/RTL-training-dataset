module sky130_fd_sc_ms__edfxbp (
    Q  ,   
    Q_N,   
    CLK,   
    D  ,   
    DE     
);
    output Q;
    output Q_N;
    input  CLK;
    input  D;
    input  DE;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB;
    supply0 VNB;
endmodule