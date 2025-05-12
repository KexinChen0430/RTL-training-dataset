module sky130_fd_io__top_refgen_new ( 
           VINREF       , 
           VOUTREF      , 
           REFLEAK_BIAS , 
           AMUXBUS_A    , 
           AMUXBUS_B    , 
           DFT_REFGEN   , 
           HLD_H_N      , 
           IBUF_SEL     , 
           ENABLE_H     , 
           ENABLE_VDDA_H, 
           VOH_SEL      , 
           VOHREF       , 
           VREF_SEL     , 
           VREG_EN      , 
           VTRIP_SEL    , 
           VOUTREF_DFT  , 
           VINREF_DFT   , 
           VCCD         , 
           VCCHIB       , 
           VDDA         , 
           VDDIO        , 
           VDDIO_Q      , 
           VSSD         , 
           VSSIO        , 
           VSSIO_Q      , 
           VSWITCH      , 
           VSSA          
       );
output       VINREF       ; 
output       VOUTREF      ; 
inout        REFLEAK_BIAS ; 
inout        AMUXBUS_A    ; 
inout        AMUXBUS_B    ; 
input        DFT_REFGEN   ; 
input        HLD_H_N      ; 
input        IBUF_SEL     ; 
input        ENABLE_H     ; 
input        ENABLE_VDDA_H; 
input  [2:0] VOH_SEL      ; 
input        VOHREF       ; 
input  [1:0] VREF_SEL     ; 
input        VREG_EN      ; 
input        VTRIP_SEL    ; 
inout        VOUTREF_DFT  ; 
inout        VINREF_DFT   ; 
inout        VCCD         ; 
inout        VCCHIB       ; 
inout        VDDA         ; 
inout        VDDIO        ; 
inout        VDDIO_Q      ; 
inout        VSSD         ; 
inout        VSSIO        ; 
inout        VSSIO_Q      ; 
inout        VSWITCH      ; 
inout        VSSA         ; 
endmodule 