module sky130_fd_sc_ms__sedfxtp (
    Q  ,  
    CLK,  
    D  ,  
    DE ,  
    SCD,  
    SCE   
);
    output Q  ;  
    input  CLK;  
    input  D  ;  
    input  DE ;  
    input  SCD;  
    input  SCE;  
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 