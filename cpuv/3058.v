module sky130_fd_sc_hdll__muxb4to1 (
    Z,   
    D,   
    S    
);
    output       Z;  
    input  [3:0] D;  
    input  [3:0] S;  
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB;  
    supply0 VNB;  
endmodule