module sky130_fd_sc_lp__bufkapwr (
    X,    
    A     
);
    output X; 
    input  A; 
    supply1 VPWR ;  
    supply0 VGND ;  
    supply1 KAPWR;  
    supply1 VPB  ;  
    supply0 VNB  ;  
endmodule 