module sky130_fd_io__top_xres4v2 (
           XRES_H_N        ,
           AMUXBUS_A       ,
           AMUXBUS_B       ,
           PAD             ,
           DISABLE_PULLUP_H,
           ENABLE_H        ,
           EN_VDDIO_SIG_H  ,
           INP_SEL_H       ,
           FILT_IN_H       ,
           PULLUP_H        ,
           ENABLE_VDDIO    ,
           PAD_A_ESD_H     ,
           TIE_HI_ESD      ,
           TIE_LO_ESD      ,
           TIE_WEAK_HI_H   ,
           VCCD            ,
           VCCHIB          ,
           VDDA            ,
           VDDIO           ,
           VDDIO_Q         ,
           VSSA            ,
           VSSD            ,
           VSSIO           ,
           VSSIO_Q         ,
           VSWITCH
       );
output XRES_H_N        ;
inout  AMUXBUS_A       ;
inout  AMUXBUS_B       ;
inout  PAD             ;
input  DISABLE_PULLUP_H;
input  ENABLE_H        ;
input  EN_VDDIO_SIG_H  ;
input  INP_SEL_H       ;
input  FILT_IN_H       ;
inout  PULLUP_H        ;
input  ENABLE_VDDIO    ;
inout  PAD_A_ESD_H     ;
output TIE_HI_ESD      ;
output TIE_LO_ESD      ;
inout  TIE_WEAK_HI_H   ;
input  VCCD            ;
input  VCCHIB          ;
input  VDDA            ;
input  VDDIO           ;
input  VDDIO_Q         ;
input  VSSA            ;
input  VSSD            ;
input  VSSIO           ;
input  VSSIO_Q         ;
input  VSWITCH         ;
endmodule