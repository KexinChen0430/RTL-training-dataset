module sky130_fd_io__top_gpio_ovtv2 (
           input        SLOW,            
           output       IN,              
           input        INP_DIS,         
           output       IN_H,            
           input        OUT,             
           inout        PAD,             
           inout        PAD_A_ESD_0_H,   
           inout        PAD_A_ESD_1_H,   
           inout        PAD_A_NOESD_H,   
           inout        AMUXBUS_A,       
           inout        AMUXBUS_B,       
           input        ANALOG_EN,       
           input        ANALOG_POL,      
           input        ANALOG_SEL,      
           input  [2:0] DM,              
           input        ENABLE_H,        
           input        ENABLE_INP_H,    
           input        ENABLE_VDDA_H,   
           input        ENABLE_VDDIO,    
           input        ENABLE_VSWITCH_H,
           input        HLD_H_N,         
           input        HLD_OVR,         
           input        HYS_TRIM,        
           input  [1:0] IB_MODE_SEL,     
           input        OE_N,            
           input  [1:0] SLEW_CTL,        
           input        VTRIP_SEL,       
           output       TIE_HI_ESD,      
           input        VINREF,          
           output       TIE_LO_ESD       
       );
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