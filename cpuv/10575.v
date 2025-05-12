module sky130_fd_sc_hd__dfxbp (  
    Q  ,                         
    Q_N,                         
    CLK,                         
    D                            
);
    output Q  ;                   
    output Q_N;                   
    input  CLK;                   
    input  D  ;                   
    supply1 VPWR;                
    supply0 VGND;                
    supply1 VPB ;                
    supply0 VNB ;                
endmodule                       