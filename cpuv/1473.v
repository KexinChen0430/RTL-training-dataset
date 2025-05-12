module sky130_fd_io__top_power_lvc_wpad (
    P_PAD,      
    AMUXBUS_A,  
    AMUXBUS_B   
);
inout P_PAD;      
inout AMUXBUS_A;  
inout AMUXBUS_B;  
supply0 SRC_BDY_LVC1; 
supply0 SRC_BDY_LVC2; 
supply1 OGC_LVC;      
supply1 DRN_LVC1;     
supply1 BDY2_B2B;     
supply0 DRN_LVC2;     
supply1 P_CORE;       
supply1 VDDIO;        
supply1 VDDIO_Q;      
supply1 VDDA;         
supply1 VCCD;         
supply1 VSWITCH;      
supply1 VCCHIB;       
supply0 VSSA;         
supply0 VSSD;         
supply0 VSSIO_Q;      
supply0 VSSIO;        
endmodule