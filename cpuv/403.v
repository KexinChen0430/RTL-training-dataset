module sky130_fd_sc_lp__dfrtn (
    Q,        
    CLK_N,    
    D,        
    RESET_B   
);
    output Q;        
    input  CLK_N;    
    input  D;        
    input  RESET_B;  
    supply1 VPWR;  
    supply0 VGND;  
    supply1 VPB;   
    supply0 VNB;   
endmodule 