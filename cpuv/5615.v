module sky130_fd_io__top_refgen_new (
           input        DFT_REFGEN   ,
           inout        AMUXBUS_A    ,
           inout        AMUXBUS_B    ,
           input        ENABLE_H     ,
           input        ENABLE_VDDA_H,
           input        HLD_H_N      ,
           input        IBUF_SEL     ,
           input  [2:0] VOH_SEL      ,
           input  [1:0] VREF_SEL     ,
           input        VREG_EN      ,
           input        VTRIP_SEL    ,
           inout        REFLEAK_BIAS ,
           output       VINREF       ,
           inout        VINREF_DFT   ,
           input        VOHREF       ,
           output       VOUTREF      ,
           inout        VOUTREF_DFT
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