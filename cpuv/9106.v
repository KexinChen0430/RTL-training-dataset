module sky130_fd_io__top_refgen (
           VINREF      ,
           VOUTREF     ,
           REFLEAK_BIAS,
           HLD_H_N     ,
           IBUF_SEL    ,
           OD_H        ,
           VOHREF      ,
           VREF_SEL    ,
           VREG_EN     ,
           VTRIP_SEL   ,
           VCCD        ,
           VCCHIB      ,
           VDDA        ,
           VDDIO       ,
           VDDIO_Q     ,
           VSSD        ,
           VSSIO       ,
           VSSIO_Q
       );
output VINREF      ;
output VOUTREF     ;
inout  REFLEAK_BIAS;
input  HLD_H_N     ;
input  IBUF_SEL    ;
input  OD_H        ;
input  VOHREF      ;
input  VREF_SEL    ;
input  VREG_EN     ;
input  VTRIP_SEL   ;
inout  VCCD        ;
inout  VCCHIB      ;
inout  VDDA        ;
inout  VDDIO       ;
inout  VDDIO_Q     ;
inout  VSSD        ;
inout  VSSIO       ;
inout  VSSIO_Q     ;
endmodule