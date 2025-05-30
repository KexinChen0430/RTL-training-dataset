module sky130_fd_io__top_refgen_new (
    input        DFT_REFGEN,   
    inout        AMUXBUS_A,    
    inout        AMUXBUS_B,    
    input        ENABLE_H,     
    input        ENABLE_VDDA_H,
    input        HLD_H_N,      
    input        IBUF_SEL,     
    input  [2:0] VOH_SEL,      
    input  [1:0] VREF_SEL,     
    input        VREG_EN,      
    input        VTRIP_SEL,    
    inout        VSWITCH,      
    inout        REFLEAK_BIAS, 
    inout        VCCD,         
    inout        VCCHIB,       
    inout        VDDA,         
    inout        VDDIO,        
    inout        VDDIO_Q,      
    output       VINREF,       
    inout        VINREF_DFT,   
    input        VOHREF,       
    output       VOUTREF,      
    inout        VOUTREF_DFT,  
    inout        VSSA,         
    inout        VSSD,         
    inout        VSSIO,        
    inout        VSSIO_Q       
);
endmodule