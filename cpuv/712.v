module sky130_fd_sc_lp__isobufsrc (
    X    ,  
    SLEEP,  
    A       
);
    output X;    
    input SLEEP; 
    input A;     
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB;  
    supply0 VNB;  
endmodule