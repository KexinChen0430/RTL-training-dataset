module sky130_fd_io__top_sio_macro (
    input        DFT_REFGEN      , 
    input  [1:0] SLOW            , 
    output [1:0] IN              , 
    input  [1:0] INP_DIS         , 
    output [1:0] IN_H            , 
    input  [1:0] OUT             , 
    inout  [1:0] PAD             , 
    inout  [1:0] PAD_A_ESD_0_H   , 
    inout  [1:0] PAD_A_ESD_1_H   , 
    inout  [1:0] PAD_A_NOESD_H   , 
    inout        AMUXBUS_A       , 
    inout        AMUXBUS_B       , 
    input  [2:0] DM0             , 
    input  [2:0] DM1             , 
    input        ENABLE_H        , 
    input        ENABLE_VDDA_H   , 
    input  [1:0] HLD_H_N         , 
    input        HLD_H_N_REFGEN  , 
    input  [1:0] HLD_OVR         , 
    input  [1:0] IBUF_SEL        , 
    input        IBUF_SEL_REFGEN , 
    input  [1:0] OE_N            , 
    input  [2:0] VOH_SEL         , 
    input  [1:0] VREF_SEL        , 
    input  [1:0] VREG_EN         , 
    input        VREG_EN_REFGEN  , 
    input  [1:0] VTRIP_SEL       , 
    input        VTRIP_SEL_REFGEN, 
    inout        VINREF_DFT      , 
    input        VOHREF          , 
    inout        VOUTREF_DFT     , 
    output [1:0] TIE_LO_ESD        
);
supply1 VCCD   ; 
supply1 VCCHIB ; 
supply1 VDDA   ; 
supply1 VDDIO  ; 
supply1 VDDIO_Q; 
supply0 VSSD   ; 
supply0 VSSIO  ; 
supply0 VSSIO_Q; 
supply1 VSWITCH; 
supply0 VSSA   ; 
endmodule