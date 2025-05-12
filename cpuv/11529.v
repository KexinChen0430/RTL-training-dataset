module sky130_fd_io__top_refgen (
    input  HLD_H_N     , 
    input  IBUF_SEL    , 
    input  OD_H        , 
    input  VREF_SEL    , 
    input  VREG_EN     , 
    input  VTRIP_SEL   , 
    inout  REFLEAK_BIAS, 
    inout  VCCD        , 
    inout  VCCHIB      , 
    inout  VDDA        , 
    inout  VDDIO       , 
    inout  VDDIO_Q     , 
    output VINREF      , 
    input  VOHREF      , 
    output VOUTREF     , 
    inout  VSSD        , 
    inout  VSSIO       , 
    inout  VSSIO_Q     
);
endmodule