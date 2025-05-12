module sky130_fd_io__top_sio (
    IN_H         , 
    PAD_A_NOESD_H, 
    PAD          , 
    DM           , 
    HLD_H_N      , 
    INP_DIS      , 
    IN           , 
    ENABLE_H     , 
    OE_N         , 
    SLOW         , 
    VTRIP_SEL    , 
    VINREF       , 
    VOUTREF      , 
    VREG_EN      , 
    IBUF_SEL     , 
    REFLEAK_BIAS , 
    PAD_A_ESD_0_H, 
    TIE_LO_ESD   , 
    HLD_OVR      , 
    OUT          , 
    PAD_A_ESD_1_H  
);
output       IN_H         ; 
inout        PAD_A_NOESD_H; 
inout        PAD          ; 
input  [2:0] DM           ; 
input        HLD_H_N      ; 
input        INP_DIS      ; 
output       IN           ; 
input        ENABLE_H     ; 
input        OE_N         ; 
input        SLOW         ; 
input        VTRIP_SEL    ; 
input        VINREF       ; 
input        VOUTREF      ; 
input        VREG_EN      ; 
input        IBUF_SEL     ; 
input        REFLEAK_BIAS ; 
inout        PAD_A_ESD_0_H; 
output       TIE_LO_ESD   ; 
input        HLD_OVR      ; 
input        OUT          ; 
inout        PAD_A_ESD_1_H; 
supply0 VSSIO  ; 
supply0 VSSIO_Q; 
supply0 VSSD   ; 
supply1 VCCD   ; 
supply1 VDDIO  ; 
supply1 VCCHIB ; 
supply1 VDDIO_Q; 
endmodule