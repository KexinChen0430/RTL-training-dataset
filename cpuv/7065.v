module sky130_fd_io__top_gpio_ovtv2 (
    OUT             , 
    OE_N            , 
    HLD_H_N         , 
    ENABLE_H        , 
    ENABLE_INP_H    , 
    ENABLE_VDDA_H   , 
    ENABLE_VDDIO    , 
    ENABLE_VSWITCH_H, 
    INP_DIS         , 
    VTRIP_SEL       , 
    HYS_TRIM        , 
    SLOW            , 
    SLEW_CTL        , 
    HLD_OVR         , 
    ANALOG_EN       , 
    ANALOG_SEL      , 
    ANALOG_POL      , 
    DM              , 
    IB_MODE_SEL     , 
    VINREF          , 
    PAD             , 
    PAD_A_NOESD_H   , 
    PAD_A_ESD_0_H   , 
    PAD_A_ESD_1_H   , 
    AMUXBUS_A       , 
    AMUXBUS_B       , 
    IN              , 
    IN_H            , 
    TIE_HI_ESD      , 
    TIE_LO_ESD      , 
);
input        OUT             ;
input        OE_N            ;
input        HLD_H_N         ;
input        ENABLE_H        ;
input        ENABLE_INP_H    ;
input        ENABLE_VDDA_H   ;
input        ENABLE_VDDIO    ;
input        ENABLE_VSWITCH_H;
input        INP_DIS         ;
input        VTRIP_SEL       ;
input        HYS_TRIM        ;
input        SLOW            ;
input  [1:0] SLEW_CTL        ;
input        HLD_OVR         ;
input        ANALOG_EN       ;
input        ANALOG_SEL      ;
input        ANALOG_POL      ;
input  [2:0] DM              ;
input  [1:0] IB_MODE_SEL     ;
input        VINREF          ;
inout        PAD             ;
inout        PAD_A_NOESD_H   ;
inout        PAD_A_ESD_0_H   ;
inout        PAD_A_ESD_1_H   ;
inout        AMUXBUS_A       ;
inout        AMUXBUS_B       ;
output       IN              ;
output       IN_H            ;
output       TIE_HI_ESD      ;
output       TIE_LO_ESD      ;
supply1 VDDIO  ;   
supply1 VDDIO_Q;   
supply1 VDDA   ;   
supply1 VCCD   ;   
supply1 VSWITCH;   
supply1 VCCHIB ;   
supply0 VSSA   ;   
supply0 VSSD   ;   
supply0 VSSIO_Q;   
supply0 VSSIO  ;   
endmodule