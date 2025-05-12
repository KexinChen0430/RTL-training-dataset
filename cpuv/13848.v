module sky130_fd_sc_hd__lpflow_isobufsrckapwr (
    input  A    , 
    output X    , 
    input  SLEEP 
);
    supply1 KAPWR; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule