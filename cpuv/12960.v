module sky130_fd_sc_hd__lpflow_inputisolatch (
    input  D      , 
    output Q      , 
    input  SLEEP_B 
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule