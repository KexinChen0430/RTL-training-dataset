module sky130_fd_sc_ms__dlrtn (
    Q      ,
    RESET_B,
    D      ,
    GATE_N
);
    output Q      ;
    input  RESET_B;
    input  D      ;
    input  GATE_N ;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule