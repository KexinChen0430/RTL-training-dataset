module sky130_fd_sc_lp__dfstp (  
    Q    ,                       
    CLK  ,                       
    D    ,                       
    SET_B                        
);
    output Q    ;                
    input  CLK  ;                
    input  D    ;                
    input  SET_B;                
    supply1 VPWR;                
    supply0 VGND;                
    supply1 VPB ;                
    supply0 VNB ;                
endmodule                       